IDENTIFICATION DIVISION.
PROGRAM-ID. CobStash-Backend-Worker.

ENVIRONMENT DIVISION.
  CONFIGURATION SECTION.
    REPOSITORY.
      *> Allows for the use of built-in functions without specifying
      *> "FUNCTION", e.g., DISPLAY TRIM('  hi   ')
      FUNCTION ALL INTRINSIC.

  INPUT-OUTPUT SECTION.
    FILE-CONTROL.
      *> Define the indexed stash file
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

    *> Raw command received from the API, such as "READ|123"
    01 WS-API-Command-Raw PIC X(400).

    *> The parsed API command
    01 WS-API-Command.
      *> The action provided by the API
      05 WS-API-Action PIC X(4).
        88 CREATE-Req VALUE "ADD".
        88 READ-Req VALUE "READ".
        88 UPDATE-Req VALUE "UPD".
        88 DELETE-Req VALUE "DEL".

      *> The individual API Arguments
      05 WS-API-Args PIC X(100) OCCURS 3 TIMES.

    *> The response returned to the API
    01 WS-Response.
      05 WS-Res-Action PIC X(4).
        88 Response-Success VALUE 'OK'.
        88 400-Bad-Req VALUE 'E400'.
        88 404-Not-Found VALUE 'E404'.
      05 FILLER PIC X VALUE '|'.
      05 WS-Res-Data PIC X(100) OCCURS 3 TIMES.

PROCEDURE DIVISION.
  *> The main program logic paragraph
  Main-Logic.
    *> Retrieve the raw API command from "stdin".
    ACCEPT WS-API-Command-Raw FROM COMMAND-LINE.

    *> Parse the raw API command into its respective fields
    UNSTRING WS-API-Command-Raw
      DELIMITED BY "|" *> Delimiter
      INTO WS-API-Action *> API Action
          WS-API-Args(1) *> Stash ID
          WS-API-Args(2) *> Stash Title
          WS-API-Args(3) *> Stash Description
      ON OVERFLOW
        *> Display an error for the API to return to the frontend
        DISPLAY 'ERROR|Too Many Arguments'
        STOP RUN RETURNING 1
    END-UNSTRING.

    *> Initialise the stash file if needed
    PERFORM Initialise-Stash.

    *> Parse the
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
        *> Display an error for the API to return to the frontend
        DISPLAY 'ERROR|Invalid Request'
        STOP RUN RETURNING 1
    END-EVALUATE.

    STOP RUN RETURNING 0.

  Initialise-Stash.
    *> Try open the file for reading and writing
    OPEN I-O FL-Stash.

    *> If the file doesn't exist
    IF WS-Stash-Status = '35' THEN
      *> Close the file's reference
      CLOSE FL-Stash

      *> Open the file for writing (creates it if it doesn't exist)
      OPEN OUTPUT FL-Stash

      *> If the file didn't open (or be created) successfully
      IF WS-Stash-Status NOT = '00' THEN
        *> Display an error for the API to return to the frontend
        DISPLAY 'ERROR|Stash could not be created'
        STOP RUN RETURNING 1
      END-IF

      CLOSE FL-Stash
    ELSE
      *> If the file couldn't open successfully
      IF WS-Stash-Status NOT = '00' THEN
        *> Display an error for the API to return to the frontend
        DISPLAY 'ERROR|Stash could not be opened'
        STOP RUN RETURNING 1
      END-IF

      CLOSE FL-Stash
    END-IF.

  API-Create.
    *> Open the stash file
    OPEN I-O FL-Stash.

    *> Assign the provided API Arguments to the file fields
    MOVE WS-API-Args(1) TO FL-Stash-Id.
    MOVE WS-API-Args(2) TO FL-Stash-Title.
    MOVE WS-API-Args(3) TO FL-Stash-Desc.

    *> Write the record to the stash file
    WRITE FL-Stash-Record
      *> If the key already exists or is otherwise invalid
      INVALID KEY
        *> Display an error for the API to return to the frontend
        DISPLAY 'ERROR|Unique Key Violation'
        CLOSE FL-Stash
        STOP RUN RETURNING 1
    END-WRITE.

    *> Read the stash file
    READ FL-Stash
      *> Use the key of the record to read the file
      KEY IS FL-Stash-Id
      *> If the key is valid
      NOT INVALID KEY
        *> Display the written ID (Temp Output)
        DISPLAY FL-Stash-Id
    END-READ.

    CLOSE FL-Stash.

END PROGRAM CobStash-Backend-Worker.
