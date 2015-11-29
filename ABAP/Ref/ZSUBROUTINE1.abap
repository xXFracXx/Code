*&---------------------------------------------------------------------*
*& Report  ZSUBROUTINE1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSUBROUTINE1.
* BY REFERENCE
*DATA: a TYPE I VALUE 10.
*
*WRITE: 'GLOBAL VALUE OF A', A.
*PERFORM SUB1 USING A.
*WRITE: 'VALUE OF A OUTSIDE SUB1 ', A.
**&---------------------------------------------------------------------*
**&      Form  SUB1
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**      -->P_A  text
**----------------------------------------------------------------------*
*form SUB1  using    p_a.
*P_A = 15.
*
*WRITE: 'VALUE OF A INSIDE SUB1 ', A.
*endform.                    " SUB1

* BY VALUE.
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
*  WRITE: 'VALUE OF A INSIDE SUB1 ', P_A.
*
*endform.                    " SUB2

* BY VALUE AND REFERENCE.

DATA: A TYPE I VALUE 10,
      B TYPE I VALUE 20.

WRITE: 'GLOBAL VALUE OF A', A,
      / 'GLOBAL VALUE OF B', B.

PERFORM SUB1 USING A CHANGING B.

WRITE: 'GLOBAL VALUE OF A OUTSIDE SUB1', A,
      / 'GLOBAL VALUE OF B OUTSIDE SUB1', B.
*&---------------------------------------------------------------------*
*&      Form  SUB1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_A  text
*      <--P_B  text
*----------------------------------------------------------------------*
form SUB1  using    VALUE(p_a)
           changing p_b.

  P_A = 40.
  P_B = 50.

 WRITE: 'VALUE OF A INSIDE SUB1', p_A,
      / 'VALUE OF B INSIDE SUB1', P_B.

endform.                    " SUB1
