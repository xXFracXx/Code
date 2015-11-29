*&---------------------------------------------------------------------*
*& Report  ZSHASH_BDC_SESSION
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_BDC_SESSION.


TYPES: BEGIN OF ty,
       ktokd TYPE ktokd,
       name1 TYPE name1,
       sortl TYPE sortl,
       ort01 TYPE ort01,
       land1 TYPE land1,
      END OF ty.

DATA: itab TYPE TABLE OF ty,
      wa TYPE ty,
      IT_BDCDATA TYPE TABLE OF BDCDATA,
      WA_BDCDATA TYPE BDCDATA.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_file TYPE rlgrap-filename,
            P_SESS TYPE C LENGTH 12 DEFAULT 'SESS'.

SELECTION-SCREEN END OF BLOCK B1.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f4_filename.

START-OF-SELECTION.

  PERFORM gui_upload.
  PERFORM bdc.
*&---------------------------------------------------------------------*
*&      Form  gui_upload
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form gui_upload .
DATA : L_FILE TYPE STRING.
  L_FILE = P_FILE.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                      = L_FILE
     FILETYPE                      = 'ASC'
     HAS_FIELD_SEPARATOR           = 'X'
*     HEADER_LENGTH                 = 0
*     READ_BY_LINE                  = 'X'
*     DAT_MODE                      = ' '
*     CODEPAGE                      = ' '
*     IGNORE_CERR                   = ABAP_TRUE
*     REPLACEMENT                   = '#'
*     CHECK_BOM                     = ' '
*     VIRUS_SCAN_PROFILE            =
*     NO_AUTH_CHECK                 = ' '
*   IMPORTING
*     FILELENGTH                    =
*     HEADER                        =
    tables
      data_tab                      = ITAB
*   EXCEPTIONS
*     FILE_OPEN_ERROR               = 1
*     FILE_READ_ERROR               = 2
*     NO_BATCH                      = 3
*     GUI_REFUSE_FILETRANSFER       = 4
*     INVALID_TYPE                  = 5
*     NO_AUTHORITY                  = 6
*     UNKNOWN_ERROR                 = 7
*     BAD_DATA_FORMAT               = 8
*     HEADER_NOT_ALLOWED            = 9
*     SEPARATOR_NOT_ALLOWED         = 10
*     HEADER_TOO_LONG               = 11
*     UNKNOWN_DP_ERROR              = 12
*     ACCESS_DENIED                 = 13
*     DP_OUT_OF_MEMORY              = 14
*     DISK_FULL                     = 15
*     DP_TIMEOUT                    = 16
*     OTHERS                        = 17
            .
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

endform.                    " gui_upload
*&---------------------------------------------------------------------*
*&      Form  f4_filename
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form f4_filename .

CALL FUNCTION 'F4_FILENAME'
 EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
   FIELD_NAME          = 'P_FILE'
 IMPORTING
   FILE_NAME           = P_FILE
          .

endform.                    " f4_filename
*&---------------------------------------------------------------------*
*&      Form  bdc
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form bdc .

PERFORM OPEN_GROUP.
PERFORM PROCESS_SCREEN.
PERFORM CLOSE_GROUP.

endform.                    " bdc
*&---------------------------------------------------------------------*
*&      Form  OPEN_GROUP
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form OPEN_GROUP .
CALL FUNCTION 'BDC_OPEN_GROUP'
 EXPORTING
   CLIENT                    = SY-MANDT
*   DEST                      = FILLER8
   GROUP                     = P_SESS
*   HOLDDATE                  = FILLER8
   KEEP                      = 'X'
   USER                      = SY-UNAME
*   RECORD                    = FILLER1
*   PROG                      = SY-CPROG
*   DCPFM                     = '%'
*   DATFM                     = '%'
* IMPORTING
*   QID                       =
* EXCEPTIONS
*   CLIENT_INVALID            = 1
*   DESTINATION_INVALID       = 2
*   GROUP_INVALID             = 3
*   GROUP_IS_LOCKED           = 4
*   HOLDDATE_INVALID          = 5
*   INTERNAL_ERROR            = 6
*   QUEUE_ERROR               = 7
*   RUNNING                   = 8
*   SYSTEM_LOCK_ERROR         = 9
*   USER_INVALID              = 10
*   OTHERS                    = 11
          .
IF sy-subrc <> 0.
 MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

endform.                    " OPEN_GROUP
*&---------------------------------------------------------------------*
*&      Form  PROCESS_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form PROCESS_SCREEN .

LOOP AT itab INTO wa.


    PERFORM bdc_dynpro      USING 'SAPMF02D' '0100'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RF02D-KTOKD'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM bdc_field       USING 'RF02D-KTOKD'
                                  wa-ktokd.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0110'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KNA1-SPRAS'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM bdc_field       USING 'KNA1-NAME1'
                                  wa-name1.
    PERFORM bdc_field       USING 'KNA1-SORTL'
                                  wa-sortl.
    PERFORM bdc_field       USING 'KNA1-ORT01'
                                  wa-ort01.
    PERFORM bdc_field       USING 'KNA1-PSTLZ'
                                  '560061'.
    PERFORM bdc_field       USING 'KNA1-LAND1'
                                  wa-land1.
    PERFORM bdc_field       USING 'KNA1-SPRAS'
                                  'en'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0120'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KNA1-LZONE'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM bdc_field       USING 'KNA1-LZONE'
                                  '0000000001'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0125'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KNA1-NIELS'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0130'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KNBK-BANKS(01)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=ENTR'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0340'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RF02D-KUNNR'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=ENTR'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0370'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RF02D-KUNNR'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=ENTR'.
    PERFORM bdc_field       USING 'KNA1-CIVVE'
                                  'X'.
    PERFORM bdc_dynpro      USING 'SAPMF02D' '0360'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KNVK-NAMEV(01)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM BDC_INSERT.

 ENDLOOP.

endform.                    " PROCESS_SCREEN
*&---------------------------------------------------------------------*
*&      Form  bdc_INSERT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form bdc_INSERT .

CALL FUNCTION 'BDC_INSERT'
 EXPORTING
   TCODE                  = 'XD01'
*   POST_LOCAL             = NOVBLOCAL
*   PRINTING               = NOPRINT
*   SIMUBATCH              = ' '
*   CTUPARAMS              = ' '
  TABLES
    dynprotab              = IT_BDCDATA
* EXCEPTIONS
*   INTERNAL_ERROR         = 1
*   NOT_OPEN               = 2
*   QUEUE_ERROR            = 3
*   TCODE_INVALID          = 4
*   PRINTING_INVALID       = 5
*   POSTING_INVALID        = 6
*   OTHERS                 = 7
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

endform.                    " bdc_INSERT
*&---------------------------------------------------------------------*
*&      Form  bdc_field
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0335   text
*      -->P_0336   text
*----------------------------------------------------------------------*
form bdc_field  using    value(p_0335)
                         value(p_0336).

CLEAR WA_BDCDATA.
 WA_BDCDATA-FNAM = P_0335.
 WA_BDCDATA-FVAL = P_0336.


 APPEND WA_BDCDATA TO IT_BDCDATA.

endform.                    " bdc_field
*&---------------------------------------------------------------------*
*&      Form  bdc_dynpro
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0330   text
*      -->P_0331   text
*----------------------------------------------------------------------*
form bdc_dynpro  using    value(p_0330)
                          value(p_0331).
CLEAR WA_BDCDATA.
WA_BDCDATA-PROGRAM = P_0330.
WA_BDCDATA-DYNPRO = P_0331.
WA_BDCDATA-DYNBEGIN = 'X'.
APPEND WA_BDCDATA TO IT_BDCDATA.

endform.                    " bdc_dynpro

*&---------------------------------------------------------------------*
*&      Form  CLOSE_GROUP
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form CLOSE_GROUP .
CALL FUNCTION 'BDC_CLOSE_GROUP'
 EXCEPTIONS
   NOT_OPEN          = 1
   QUEUE_ERROR       = 2
   OTHERS            = 3
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

endform.                    " CLOSE_GROUP
