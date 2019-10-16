class ZCL_SHOP_SO_TXT_DB definition
  public
  create public .

public section.

  interfaces ZIF_SHOP_SO_TXT_DB .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_SO_TXT_DB IMPLEMENTATION.


  METHOD zif_shop_so_txt_db~create.

    SELECT COUNT(*) FROM zshop_so_txt
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr
        AND line      = is_data-line.

    IF sy-dbcnt > 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_already_exists
        EXPORTING
          textid = zcx_shop_dbdata_already_exists=>data_found.
    ENDIF.

    INSERT zshop_so_txt FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>create_error
          mv_table_name = 'ZSHOP_SO_TXT'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_txt_db~delete.

    SELECT COUNT(*) FROM zshop_so_txt
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr
        AND line      = is_data-line.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

    DELETE zshop_so_txt FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>delete_error
          mv_table_name = 'ZSHOP_SO_TXT'.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_txt_db~read.

    DATA: lr_sales_order_id   TYPE RANGE OF vbeln,
          lr_sales_order_item TYPE RANGE OF posnr,
          lr_text_line        TYPE RANGE OF zshop_text_line.

    MOVE-CORRESPONDING is_selection_fields-so_number TO lr_sales_order_id.
    MOVE-CORRESPONDING is_selection_fields-posnr     TO lr_sales_order_item.
    MOVE-CORRESPONDING is_selection_fields-line      TO lr_text_line.

    SELECT * FROM zshop_so_txt INTO TABLE rt_data
      WHERE so_number IN lr_sales_order_id
        AND posnr     IN lr_sales_order_item
        AND line      IN lr_text_line.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_txt_db~read_by_id.

    SELECT SINGLE * FROM zshop_so_txt INTO rs_data
      WHERE so_number = iv_sales_order_id
        AND posnr     = iv_sales_order_item
        AND line      = iv_text_line.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

  ENDMETHOD.


  METHOD zif_shop_so_txt_db~update.

    SELECT COUNT(*) FROM zshop_so_txt
      WHERE so_number = is_data-so_number
        AND posnr     = is_data-posnr
        AND line      = is_data-line.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_shop_dbdata_not_found
        EXPORTING
          textid = zcx_shop_dbdata_not_found=>no_data.
    ENDIF.

    MODIFY zshop_so_txt FROM is_data.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_shop_db_access_error
        EXPORTING
          textid        = zcx_shop_db_access_error=>update_error
          mv_table_name = 'ZSHOP_SO_TXT'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
