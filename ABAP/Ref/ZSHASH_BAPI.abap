*&---------------------------------------------------------------------*
*& Report  ZSHASH_BAPI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHASH_BAPI.

TABLES: EKKO.

TYPES: BEGIN OF TY.
  INCLUDE STRUCTURE BAPIEKPO.
TYPES: END OF TY.


DATA : ITAB TYPE TABLE OF TY,
      WA LIKE LINE OF ITAB.

PARAMETERS: P_EBELN TYPE EKKO-EBELN.

CALL FUNCTION 'BAPI_PO_GETDETAIL'
  EXPORTING
    purchaseorder                    = P_EBELN
*   ITEMS                            = 'X'
*   ACCOUNT_ASSIGNMENT               = ' '
*   SCHEDULES                        = ' '
*   HISTORY                          = ' '
*   ITEM_TEXTS                       = ' '
*   HEADER_TEXTS                     = ' '
*   SERVICES                         = ' '
*   CONFIRMATIONS                    = ' '
*   SERVICE_TEXTS                    = ' '
*   EXTENSIONS                       = ' '
* IMPORTING
*   PO_HEADER                        =
*   PO_ADDRESS                       =
 TABLES
*   PO_HEADER_TEXTS                  =
   PO_ITEMS                         = ITAB
*   PO_ITEM_ACCOUNT_ASSIGNMENT       =
*   PO_ITEM_SCHEDULES                =
*   PO_ITEM_CONFIRMATIONS            =
*   PO_ITEM_TEXTS                    =
*   PO_ITEM_HISTORY                  =
*   PO_ITEM_HISTORY_TOTALS           =
*   PO_ITEM_LIMITS                   =
*   PO_ITEM_CONTRACT_LIMITS          =
*   PO_ITEM_SERVICES                 =
*   PO_ITEM_SRV_ACCASS_VALUES        =
*   RETURN                           =
*   PO_SERVICES_TEXTS                =
*   EXTENSIONOUT                     =
          .


LOOP AT ITAB INTO WA.

  WRITE: / 'PO_NUMBER = ' , WA-PO_NUMBER,
         / 'PO ITEM = ', WA-PO_ITEM,
         / 'MATERIAL = ', WA-MATERIAL,
         / 'PLANT =', WA-PLANT.
  ULINE.

 ENDLOOP.
