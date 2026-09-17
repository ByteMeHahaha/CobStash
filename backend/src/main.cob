IDENTIFICATION DIVISION.
PROGRAM-ID. CobStash-Backend-Worker.

ENVIRONMENT DIVISION.
  INPUT-OUTPUT SECTION.
    FILE-CONTROL.
      SELECT FL-Stash ASSIGN TO './data/Stash.dat'
      ORGANISATION INDEXED
      ACCESS MODE DYNAMIC
      RECORD KEY FL-Stash-Id
      FILE STATUS WS-Stash-Status.

DATA DIVISION.
  FILE SECTION.
    FD FL-Stash.
    01 FL-Stash-Record.
      05 FL-Stash-Id PIC 9(6) VALUE ZEROS.
      05 FL-Stash-Title PIC X(20) VALUE SPACES.
      05 FL-Stash-Desc PIC X(100) VALUE SPACES.

  WORKING-STORAGE SECTION.
    *> File Status Codes
    01 WS-Stash-Status PIC XX.
    01 WS-Export-Status PIC XX.

    *> Raw command received from the API, such as "READ|123"
    01 WS-API-Command-Raw PIC X(400).

    *> The parsed API command
    01 WS-API-Command.
      05 WS-API-Action PIC X(4).
        88 CREATE-Req VALUE "ADD".
        88 READ-Req VALUE "READ".
        88 UPDATE-Req VALUE "UPD".
        88 DELETE-Req VALUE "DEL".

      05 WS-API-Args OCCURS 3 TIMES.
        10 WS-API-Arg PIC X(100).

PROCEDURE DIVISION.
  Main-Logic.
    *> Retrieve the raw API command from "stdin".
    ACCEPT WS-API-Command-Raw FROM COMMAND-LINE.

    *> Parse the raw API command into its respective fields
    UNSTRING WS-API-Command-Raw
      DELIMITED BY "|"
      INTO WS-API-Action *> API Action
          WS-API-Args(1) *> Stash ID
          WS-API-Args(2) *> Stash Title
          WS-API-Args(3) *> Stash Description
      ON OVERFLOW
        DISPLAY 'ERROR|Too Many Arguments'
        STOP RUN RETURNING 1
    END-UNSTRING.

    EVALUATE TRUE
      WHEN CREATE-Req
        PERFORM API-Create
      WHEN READ-Req
        *> Temporary Output
        DISPLAY 'READ Request'
      WHEN UPDATE-Req
        *> Temporary Output
        DISPLAY 'UPDATE Request'
      WHEN DELETE-Req
        *> Temporary Output
        DISPLAY 'DELETE Request'
      WHEN OTHER
        DISPLAY 'ERROR|Invalid Request'
        STOP RUN RETURNING 1
    END-EVALUATE.

    STOP RUN RETURNING 0.

  API-Create.
    DISPLAY FUNCTION TRIM(WS-API-Action) '|' WITH NO ADVANCING.
    DISPLAY FUNCTION TRIM(WS-API-Args(1)) '|' WITH NO ADVANCING.
    DISPLAY FUNCTION TRIM(WS-API-Args(2)) '|' WITH NO ADVANCING.
    DISPLAY FUNCTION TRIM(WS-API-Args(3)).

END PROGRAM CobStash-Backend-Worker.
