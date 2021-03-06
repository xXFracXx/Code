*&---------------------------------------------------------------------*
*& Report  ZSHAS_INTERACTIVEREPORT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHAS_INTERACTIVEREPORT.

TABLES: VBAK.
LOAD-OF-PROGRAM.
TYPES: BEGIN OF TY,
      VBELN TYPE VBELN ,
      ERNAM TYPE C LENGTH 12,
      ERDAT TYPE VBAK-ERDAT,
      AUART(4) TYPE C,
      END OF TY.

TYPES: BEGIN OF TY1,
      VBELN TYPE VBELN,
      POSNR TYPE POSNR,
      MATNR TYPE MATNR,
      END OF TY1.


      "PARAMETERS: P_VBELN TYPE VBAK-VBELN.
      SELECT-OPTIONS: S_VBELN FOR VBAK-VBELN ."OBLIGATORY.
INITIALIZATION.
S_VBELN-SIGN = 'IN'.
S_VBELN-OPTION = 'EQ'. " EQ , GT, LT, GE, LE
S_VBELN-LOW = '4500'.
S_VBELN-HIGH = '5500'.

APPEND S_VBELN.

AT SELECTION-SCREEN .
  IF S_VBELN-HIGH = ''.
    MESSAGE 'PLEASE USE A NUMBER' TYPE 'E'.
   ENDIF.
START-OF-SELECTION.
   DATA : ITAB TYPE TABLE OF TY,
         WA LIKE LINE OF ITAB,
         ITAB1 TYPE TABLE OF TY1,
         WA1 TYPE TY1.
        " WA TYPE TY.

  "  SELECT VBELN ERNAM ERDAT AUART FROM VBAK INTO TABLE ITAB WHERE VBELN = P_VBELN. "WHEN USING PARAMETERS

"SELECT VBELN ERNAM ERDAT AUART FROM VBAK INTO TABLE ITAB UP TO 50 ROWS.
 SELECT VBELN ERNAM ERDAT AUART FROM VBAK INTO TABLE ITAB WHERE VBELN IN S_VBELN." WHEN USING SELECT-OPTIONS.
END-OF-SELECTION.
WRITE: 'NO', 15 'SALES DOC', 30 'CREATED BY', 45 'CREATED ON', 60 'DOC TYPE'.
"SORT ITAB BY ERNAM.
     WRITE: 'NO OF RECORDS =', SY-DBCNT.
     SKIP 3.
      LOOP AT ITAB INTO WA .
        WRITE: / SY-TABIX, 15 WA-VBELN COLOR 4, 30 WA-ERNAM, 45 WA-ERDAT, 60 WA-AUART.
        HIDE: WA-VBELN.
        ENDLOOP.
*        TOP-OF-PAGE.
*WRITE: 'SALES DOCUMENTS CREATED BY ' , SY-UNAME.
*SKIP.
*
*END-OF-PAGE.
*WRITE:  'PAGE NO = ', SY-PAGNO,
*      / 'CREATED ON =', SY-DATUM.
 AT LINE-SELECTION.
   IF SY-LSIND = 1.
     SELECT VBELN POSNR MATNR FROM VBAP INTO TABLE ITAB1.
    ENDIF.
       LOOP AT ITAB1 INTO WA1 WHERE VBELN = WA-VBELN.
         WRITE: / WA1-VBELN, WA1-POSNR, WA1-MATNR.

       ENDLOOP.
