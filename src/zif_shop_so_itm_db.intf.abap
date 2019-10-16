interface ZIF_SHOP_SO_ITM_DB
  public .


  methods CREATE
    importing
      !IS_DATA type ZSHOP_SO_ITM
    raising
      ZCX_SHOP_DBDATA_ALREADY_EXISTS
      ZCX_SHOP_DB_ACCESS_ERROR .
  methods READ
    importing
      !IS_SELECTION_FIELDS type ZSHOP_SO_ITM_SELECTION
    returning
      value(RT_DATA) type ZSHOP_SO_ITM_TAB
    raising
      ZCX_SHOP_DBDATA_NOT_FOUND .
  methods READ_BY_ID
    importing
      !IV_SALES_ORDER_ID type VBELN
      !IV_SALES_ORDER_ITEM type POSNR
    returning
      value(RS_DATA) type ZSHOP_SO_ITM
    raising
      ZCX_SHOP_DBDATA_NOT_FOUND .
  methods UPDATE
    importing
      !IS_DATA type ZSHOP_SO_ITM
    raising
      ZCX_SHOP_DBDATA_NOT_FOUND
      ZCX_SHOP_DB_ACCESS_ERROR .
  methods DELETE
    importing
      !IS_DATA type ZSHOP_SO_ITM
    raising
      ZCX_SHOP_DBDATA_NOT_FOUND
      ZCX_SHOP_DB_ACCESS_ERROR .
endinterface.
