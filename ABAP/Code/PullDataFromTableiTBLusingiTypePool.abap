*&---------------------------------------------------------------------*
*& Report  YDATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YDATA.

TYPE-POOLS: ZTBL.

DATA : ITAB TYPE TABLE OF ZTBL_TBL,
       FS LIKE LINE OF ITAB.

SELECT IDNUM FIRSTNAME GRADE AREA STREAM FROM YSTUDENTS_DXB INTO TABLE ITAB.

LOOP AT ITAB INTO FS.
  WRITE : / FS-IDNUM, FS-NAME, FS-GRADE, FS-AREA, FS-STREAM.
ENDLOOP.