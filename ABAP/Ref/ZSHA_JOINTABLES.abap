*&---------------------------------------------------------------------*
*& Report  ZSHA_JOINTABLES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZSHA_JOINTABLES.

TABLES: VBAK.

TYPES: BEGIN OF TY,
      VBELN TYPE VBELN ,
      ERNAM TYPE C LENGTH 12,
      ERDAT TYPE VBAK-ERDAT,
      AUART(4) TYPE C,
      POSNR TYPE POSNR,
      MATNR TYPE MATNR,
      END OF TY.

DATA : ITAB TYPE TABLE OF TY,
         WA LIKE LINE OF ITAB.




 SELECT VBAK~VBELN VBAK~ERNAM VBAK~ERDAT VBAK~AUART VBAP~POSNR VBAP~MATNR FROM VBAK INNER JOIN VBAP ON
   VBAK~VBELN = VBAP~VBELN  INTO TABLE ITAB.


      LOOP AT ITAB INTO WA .

        WRITE: /  WA-VBELN,  WA-ERNAM,  WA-ERDAT,  WA-AUART, WA-POSNR, WA-MATNR.

        ENDLOOP.
