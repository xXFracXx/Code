*&---------------------------------------------------------------------*
*& Report  YDATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YDATA.

DATA : BEGIN OF iTBL OCCURS 0,
       IDNUM TYPE YSTUDIDNUM,
       NAME TYPE YSTUDFNAME,
       GRADE TYPE YSTUDGRADE,
       AREA TYPE YSTUDAREA,
       STREAM TYPE YSTUDSTREAM,
       END OF iTBL.

SELECT IDNUM FIRSTNAME GRADE AREA STREAM FROM YSTUDENTS_DXB INTO iTBL.
  APPEND iTBL.
ENDSELECT.

LOOP AT iTBL.
  WRITE : / iTBL-IDNUM, iTBL-NAME, iTBL-GRADE, iTBL-AREA, iTBL-STREAM.
ENDLOOP.