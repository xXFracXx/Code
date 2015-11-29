*&---------------------------------------------------------------------*
*& Report  ZSHASH_ALV_INTERACTIVE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_ALV_INTERACTIVE.
TYPE-POOLS : SLIS.
TYPES: BEGIN OF TY,
  VBELN TYPE VBELN,
  ERNAM TYPE ERNAM,
  AUART TYPE AUART,
  END OF TY.

TYPES: BEGIN OF TY1,
    VBELN TYPE VBELN,
    POSNR TYPE POSNR,
    MATNR TYPE MATNR,
    END OF TY1.

 DATA: ITAB TYPE TABLE OF TY,
       WA LIKE LINE OF ITAB,
       IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
       WA_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
       ITAB1 TYPE TABLE OF TY1,
       WA1 LIKE LINE OF ITAB1,
       IT_FIELDCAT1 TYPE SLIS_T_FIELDCAT_ALV,
       WA_FIELDCAT1 TYPE SLIS_FIELDCAT_ALV.

  SELECT VBELN ERNAM AUART FROM VBAK INTO TABLE ITAB UP TO 30 ROWS.

    PERFORM BUILDCAT.
    PERFORM DISPLAY_ALV.
*&---------------------------------------------------------------------*
*&      Form  BUILDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form BUILDCAT .

PERFORM ADDFIELD USING: 'VBELN' 'DOC NUMBER',
                        'ERNAM' 'CREATED BY',
                        'AUART' 'DOC TYPE'.
endform.                    " BUILDCAT
*&---------------------------------------------------------------------*
*&      Form  ADDFIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0067   text
*      -->P_0068   text
*----------------------------------------------------------------------*
form ADDFIELD  using    value(p_0067)
                        value(p_0068).

WA_FIELDCAT-FIELDNAME = P_0067.
WA_FIELDCAT-SELTEXT_M = P_0068.
APPEND WA_FIELDCAT TO IT_FIELDCAT.

endform.                    " ADDFIELD
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form DISPLAY_ALV .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = SY-REPID
*   I_CALLBACK_PF_STATUS_SET          = ' '
   I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'

   IT_FIELDCAT                       = IT_FIELDCAT

  TABLES
    t_outtab                          = ITAB
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
REFRESH IT_FIELDCAT.
endform.                    " DISPLAY_ALV

* FORM USER_COMMAND.

FORM USER_COMMAND USING RCOMM TYPE SY-UCOMM RS_SELFIELD TYPE SLIS_SELFIELD.

  READ TABLE ITAB INTO WA INDEX RS_SELFIELD-TABINDEX.


  SELECT VBELN POSNR MATNR FROM VBAP INTO TABLE ITAB1 WHERE VBELN = WA-VBELN.

    PERFORM BUILDCAT1.
    PERFORM ALV1.

ENDFORM.
*
*&---------------------------------------------------------------------*
*&      Form  BUILDCAT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form BUILDCAT1 .
PERFORM ADDFIELD1 USING : 'VBELN' 'DOC NO',
                         'POSNR' 'ITEM NO',
                         'MATNR' 'MATERIAL CODE'.

endform.                    " BUILDCAT1
*&---------------------------------------------------------------------*
*&      Form  ADDFIELD1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0195   text
*      -->P_0196   text
*----------------------------------------------------------------------*
form ADDFIELD1  using    value(p_0195)
                         value(p_0196).

WA_FIELDCAT1-FIELDNAME = P_0195.
WA_FIELDCAT1-SELTEXT_M = P_0196.

APPEND WA_FIELDCAT1 TO IT_FIELDCAT1.

endform.                    " ADDFIELD1
*&---------------------------------------------------------------------*
*&      Form  ALV1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form ALV1 .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING

   IT_FIELDCAT                       = IT_FIELDCAT1

  TABLES
    t_outtab                          = ITAB1
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
REFRESH IT_FIELDCAT1.
endform.                    " ALV1
