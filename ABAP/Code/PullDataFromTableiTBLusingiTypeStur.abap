*&---------------------------------------------------------------------*
*& Report  YDATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YDATA.

TYPES : BEGIN OF TY,
        IDNUM TYPE YSTUDIDNUM,
        FIRSTNAME TYPE YSTUDFNAME,
        GRADE TYPE YSTUDGRADE,
        AREA TYPE YSTUDAREA,
        STREAM TYPE YSTUDSTREAM,
        END OF TY.

DATA : ITAB TYPE TABLE OF TY,
       WA LIKE LINE OF ITAB.

SELECT IDNUM FIRSTNAME GRADE AREA STREAM FROM YSTUDENTS_DXB INTO TABLE ITAB.

LOOP AT ITAB INTO WA.
  WRITE : / WA-IDNUM, WA-FIRSTNAME, WA-GRADE, WA-AREA, WA-STREAM.
ENDLOOP.