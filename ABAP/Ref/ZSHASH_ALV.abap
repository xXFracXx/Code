*&---------------------------------------------------------------------*
*& Report  ZSHASH_ALV
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_ALV.
TYPE-POOLS : SLIS.
TYPES: BEGIN OF TY,
  VBELN TYPE VBELN,
  ERNAM TYPE ERNAM,
  AUART TYPE AUART,
  END OF TY.

 DATA: ITAB TYPE TABLE OF TY,
       WA LIKE LINE OF ITAB,
       IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
       WA_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

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
  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK              = ' '
*     I_BYPASSING_BUFFER             =
*     I_BUFFER_ACTIVE                = ' '
*     I_CALLBACK_PROGRAM             = ' '
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
*     I_STRUCTURE_NAME               =
*     IS_LAYOUT                      =
     IT_FIELDCAT                    = IT_FIELDCAT
*     IT_EXCLUDING                   =
*     IT_SPECIAL_GROUPS              =
*     IT_SORT                        =
*     IT_FILTER                      =
*     IS_SEL_HIDE                    =
*     I_DEFAULT                      = 'X'
*     I_SAVE                         = ' '
*     IS_VARIANT                     =
*     IT_EVENTS                      =
*     IT_EVENT_EXIT                  =
*     IS_PRINT                       =
*     IS_REPREP_ID                   =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE              = 0
*     IR_SALV_LIST_ADAPTER           =
*     IT_EXCEPT_QINFO                =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    TABLES
      t_outtab                       = ITAB
*   EXCEPTIONS
*     PROGRAM_ERROR                  = 1
*     OTHERS                         = 2
            .
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
* EXPORTING
*
*   IT_FIELDCAT                       = IT_FIELDCAT
*
*  TABLES
*    t_outtab                          = ITAB
** EXCEPTIONS
**   PROGRAM_ERROR                     = 1
**   OTHERS                            = 2
*          .
*IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*ENDIF.
*
*
endform.                    " DISPLAY_ALV
