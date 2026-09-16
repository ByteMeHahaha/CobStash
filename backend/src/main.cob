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

    *> Command line argument(s).
    01 WS-CLI-Args PIC X(200).

    *> The command from the API, such as "READ|123"
    01 WS-API-Command.
      05 WS-API-Action PIC X(4).
        88 CREATE-Req VALUE "ADD".
        88 READ-Req VALUE "READ".
        88 UPDATE-Req VALUE "UPD".
        88 DELETE-Req VALUE "DEL".

      05 WS-API-Args OCCURS 3 TIMES.
        10 WS-API-Arg PIC X(100).

PROCEDURE DIVISION.
  ACCEPT WS-CLI-Args FROM COMMAND-LINE.
  DISPLAY WS-CLI-Args.

  *> TODO => Process stdin input with STRING verb

  STOP RUN RETURNING 0.

END PROGRAM CobStash-Backend-Worker.
