*&---------------------------------------------------------------------*
*& Report  ZSHASH_DBUPDATE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_DBUPDATE." MESSAGE-ID ZABAP.

*TYPES: BEGIN OF TY,
*       MATNR TYPE MATNR,
*  ERSDA TYPE ERSDA
TABLES: ZSHASH_DBUPDATE.
DATA: ITAB TYPE TABLE OF ZSHASH_DBUPDATE,
      WA TYPE ZSHASH_DBUPDATE.

SELECT MATNR ERSDA ERNAM MTART FROM MARA INTO TABLE ITAB ."UP TO ROWS.
DELETE ADJACENT DUPLICATES FROM ITAB COMPARING ALL FIELDS.
*IF SY-SUBRC = 0.
*  LOOP AT ITAB INTO WA.
*    INSERT ZSHASH_DBUPDATE FROM WA.
*  ENDLOOP.
* WRITE: ' TABLE UPDATES'.

 " MESSAGE  'TABLE NOT UPDATED' TYPE 'I'.
 " MESSAGE E000(ZABAP).
" MESSAGE E000.
 MESSAGE E111 WITH TEXT-000.

* ENDIF.
 "DELETE FROM ZSHASH_DBUPDATE." WHERE MTART = 'FERT'.
