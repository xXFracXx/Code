*&---------------------------------------------------------------------*
*& Report  YPROGRAM1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YPROGRAM1.

WRITE : 'Hi',
      / 'I like ABAP',
      / 'I am learning at the Tech Guide Institue'.

DO.
  WRITE : / SY-INDEX COLOR 4.
  IF SY-INDEX = 20.
    EXIT.
  ENDIF.
ENDDO.