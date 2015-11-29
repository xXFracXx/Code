*&---------------------------------------------------------------------*
*& Report  ZSHASH_USING_FM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_USING_FM.


DATA: ITAB TYPE TABLE OF VBAK,
      WA TYPE VBAK.


CALL FUNCTION 'Z_READ_FROM_VBAK'
  TABLES
    itab            = ITAB
* EXCEPTIONS
*   NOT_FOUND       = 1
*   OTHERS          = 2
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

LOOP AT ITAB INTO WA.
  WRITE: / WA-VBELN, WA-ERNAM, WA-ERDAT, WA-AUART.
ENDLOOP.
