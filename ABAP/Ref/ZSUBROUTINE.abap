*&---------------------------------------------------------------------*
*& Report  ZSUBROUTINE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSUBROUTINE.

* SUBROUTINE BY REFERENCE.
DATA: A TYPE I VALUE 10.

WRITE: 'GLOBAL VALUE OF A', A.
PERFORM SUB1 USING A.
WRITE: 'VALUE OF A OUTSIDE SUB1 ', A.


** BY VALUE.
*
*DATA: A TYPE I VALUE 20.
*
*WRITE: 'GLOBAL VALUE OF A', A.
*PERFORM SUB2 USING A.
*WRITE: 'VALUE OF A OUTSIDE SUB1 ', A.
**&---------------------------------------------------------------------*
**&      Form  SUB2
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**      -->P_A  text
**----------------------------------------------------------------------*
*form SUB2  using    VALUE(p_a).
*
*  P_A = 15.
*  WRITE: 'VALUE OF A INSIDE SUB1 ', P_A
*
*endform.                    " SUB2
