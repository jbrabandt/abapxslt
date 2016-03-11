*&---------------------------------------------------------------------*
*& Report  /ENSX/TEST_SIMPLE_TRANSFORM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT /ensx/test_simple_trans_json.
DATA lcx_root       TYPE REF TO cx_root.
DATA text           TYPE string.
DATA use_camel_case TYPE boolean.
DATA transformation TYPE string VALUE '/ENSX/TEST_CUSTOMER_JSON'.
DATA serializer     TYPE REF TO /ensx/cl_re_sxml_provider.
DATA stream         TYPE xstring.
DATA xml            TYPE xstring.
DATA string         TYPE string.
DATA output         TYPE REF TO if_demo_output.

DATA: lr_obj      TYPE REF TO /ensx/if_busobj.
DATA: lr_objdata  TYPE REF TO /ensx/if_objdata.
DATA: lr_ref      TYPE REF TO data.
DATA: or_ref      TYPE REF TO data.
DATA: i_editmode  TYPE boole_d.
FIELD-SYMBOLS <data> TYPE any.
TRY.

    CREATE OBJECT serializer
      EXPORTING
        use_camel_case = use_camel_case
        transformation = transformation.

    /ensx/cl_busobj_factory=>create_obj( EXPORTING i_type = 'EnosixCustomer'
                                                   i_key  = '1'
                                         IMPORTING e_obj  = lr_obj
                                         CHANGING  c_editmode = i_editmode ).

    lr_obj->/ensx/if_busobj_db~getdetail( ). "IMPORTING success = success return = lt_bapiret ).

    lr_objdata ?= lr_obj.
    lr_ref = lr_objdata->get_attribute_by_ref(
        i_recordset = 'DATASET'
           ).
    ASSIGN lr_ref->* TO <data>.

    serializer->/ensx/if_re_sxml_provider~add_source(
        name   = 'DATASET'
        value  = <data>
     "dref   = lr_ref
           ).

    serializer->set_stream_type( iv_stream_type = if_sxml=>co_xt_json ).

    stream = serializer->/ensx/if_re_sxml_provider~serialize( ).

    cl_demo_output=>display_xml( xml = stream ).
    string = cl_abap_codepage=>convert_from( stream ).
    cl_demo_output=>display_text( text = string ).

    CREATE DATA or_ref LIKE <data>.
    serializer->/ensx/if_re_sxml_provider~set_stream_type( iv_stream_type = if_sxml=>co_xt_json ).

    serializer->/ensx/if_re_sxml_provider~deserialize(
      EXPORTING
        iv_stream    = stream
        iv_root_node = 'DATASET'
      IMPORTING
        oref_data    = or_ref
           ).
    BREAK-POINT.
  CATCH cx_xslt_runtime_error
        /ensx/cx_re_http INTO lcx_root.
    /ensx/cl_abap_exceptions=>_show_exception( exception = lcx_root ).
ENDTRY.