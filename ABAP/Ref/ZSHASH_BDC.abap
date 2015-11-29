REPORT zshash_bdc
       NO STANDARD PAGE HEADING LINE-SIZE 255.

INCLUDE bdcrecx1.

TYPES: BEGIN OF ty,
       ktokd TYPE ktokd,
       name1 TYPE name1,
       sortl TYPE sortl,
       ort01 TYPE ort01,
       land1 TYPE land1,
      END OF ty.

DATA: itab TYPE TABLE OF ty,
      wa TYPE ty.
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_file TYPE rlgrap-filename.
SELECTION-SCREEN END OF BLOCK B1.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f4_filename.

START-OF-SELECTION.

  PERFORM gui_upload.
  PERFORM bdc.


*&---------------------------------------------------------------------*
*&      Form  F4_FILENAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f4_filename .
  CALL FUNCTION 'F4_FILENAME'
   EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
     field_name          = 'P_FILE'
   IMPORTING
     file_name           = p_file
            .

ENDFORM.                    " F4_FILENAME
*&---------------------------------------------------------------------*
*&      Form  GUI_UPLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM gui_upload .

  DATA: l_file TYPE string.
  l_file = p_file.

  CALL FUNCTION 'GUI_UPLOAD'

    EXPORTING
      filename                      = l_file
     filetype                      = 'ASC'
     has_field_separator           = 'X'
*   HEADER_LENGTH                 = 0
*   READ_BY_LINE                  = 'X'
*   DAT_MODE                      = ' '
*   CODEPAGE                      = ' '
*   IGNORE_CERR                   = ABAP_TRUE
*   REPLACEMENT                   = '#'
*   CHECK_BOM                     = ' '
*   VIRUS_SCAN_PROFILE            =
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
*   HEADER                        =
    TABLES
      data_tab                      = itab
* EXCEPTIONS
*   FILE_OPEN_ERROR               = 1
*   FILE_READ_ERROR               = 2
*   NO_BATCH                      = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE                  = 5
*   NO_AUTHORITY                  = 6
*   UNKNOWN_ERROR                 = 7
*   BAD_DATA_FORMAT               = 8
*   HEADER_NOT_ALLOWED            = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG               = 11
*   UNKNOWN_DP_ERROR              = 12
*   ACCESS_DENIED                 = 13
*   DP_OUT_OF_MEMORY              = 14
*   DISK_FULL                     = 15
*   DP_TIMEOUT                    = 16
*   OTHERS                        = 17
            .
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.                    " GUI_UPLOAD
*&---------------------------------------------------------------------*
*&      Form  BDC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM bdc .
  LOOP AT itab INTO wa.

    PERFORM open_group.

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
                                  '=ENTR'.
    PERFORM bdc_transaction USING 'XD01'.

    PERFORM close_group.
ENDLOOP.
  ENDFORM.                    " BDC
