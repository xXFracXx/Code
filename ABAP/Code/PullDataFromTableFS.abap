*&---------------------------------------------------------------------*
*& Report  YDATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YDATA.

DATA : BEGIN OF TBL,
       ROLLNO TYPE YROLLNO,
       NAME TYPE YSTUDNAME,
       GRADE TYPE YSTUDGRADE,
       AREA TYPE YSTUDAREA,
       STREAM TYPE YSTUDSTREAM,
       END OF TBL.

SELECT ROLLNO NAME GRADE AREA STREAM FROM YSTUDENTS_DXB INTO TBL.
  WRITE : / TBL-ROLLNO, TBL-NAME, TBL-GRADE, TBL-AREA, TBL-STREAM.
ENDSELECT.
  