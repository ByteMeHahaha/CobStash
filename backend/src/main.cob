IDENTIFICATION DIVISION.
PROGRAM-ID. CobStash.

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
    01 WS-Command PIC X(200).

PROCEDURE DIVISION.
  ACCEPT WS-Command FROM COMMAND-LINE.
  DISPLAY WS-Command.

  *> TODO => Process stdin input with STRING verb

  STOP RUN RETURNING 0.

END PROGRAM CobStash.
