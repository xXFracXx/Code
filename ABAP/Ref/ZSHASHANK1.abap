*&---------------------------------------------------------------------*
*& Report  ZSHASHANK1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASHANK1.
*write : 'This is my first program',
*       / 'I loe ABAP',
*       / 'I am from ', " Dubai.
*/ 'rrrrrrrrrrrrrrrr',
*/ 'ggg'.

*LOOPS

*1. DO - ENDDO LOOP . CONTINOUS LOOP
*2. WHILE - ENDWHILE LOOP. CONDITIONAL LOOP
*3. SELECT - ENDSELECT LOOP . LOOPING IN DB TABLE.
*4. LOOP AT - ENDLOOP. LOOPING IN INTERNAL TABLE.

*DO .
*
*  WRITE : / SY-INDEX COLOR 4.
*  IF SY-INDEX  = 2.
*    WRITE 'HI'.
*  ENDIF.
*  IF SY-INDEX  = 10.
*    EXIT.
*  ENDIF.
*
*ENDDO.

WHILE SY-INDEX < 5.
  WRITE SY-INDEX.

ENDWHILE.
