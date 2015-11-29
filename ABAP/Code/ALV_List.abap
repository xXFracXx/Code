*&---------------------------------------------------------------------*
*& Report  YALV
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  YALV.
TYPE-POOLS : SLIS.
TYPES : BEGIN OF TBL,
        IDNUM TYPE YSTUDIDNUM,
        FIRSTNAME TYPE YSTUDFNAME,
        GRADE TYPE YSTUDGRADE,
        AREA TYPE YSTUDAREA,
        STREAM TYPE YSTUDSTREAM,
        END OF TBL.

DATA : ITAB TYPE TABLE OF TBL,
       WA LIKE LINE OF ITAB,
       IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
       WA_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

SELECT IDNUM FIRSTNAME GRADE AREA STREAM FROM YSTUDENTS_DXB INTO TABLE ITAB.

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

  PERFORM ADDFIELD USING: 'IDNUM'     'ROLL NUMBER',
                          'FIRSTNAME' 'FIRST NAME',
                          'GRADE'     'GRADE',
                          'AREA'      'AREA',
                          'STREAM'    'STREAM'.

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
endform.                    " DISPLAY_ALV
