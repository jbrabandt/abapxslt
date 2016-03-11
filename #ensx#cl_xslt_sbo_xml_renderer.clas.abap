class /ENSX/CL_XSLT_SBO_XML_RENDERER definition
  public
  inheriting from /ENSX/CL_XSLT_XML_RENDERER
  create public .

public section.

  data GO_FRIENDLYFIELDS type ref to /ENSX/CL_OBJECT_FLD_MAP .

  methods _GET_FRIEMDLY_FIELDNAME
    importing
      !FIELDNAME type STRING
      !PATH type STRING
    returning
      value(FRIENDLYNAME) type STRING .
  methods CONSTRUCTOR
    importing
      !BUS_OBJ type /ENSX/BUSOBJ_TYP .

  methods _GET_ELEMENT_NAME
    redefinition .
  methods __CHECK_FLATTEN_CONDITION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ENSX/CL_XSLT_SBO_XML_RENDERER IMPLEMENTATION.


  METHOD CONSTRUCTOR.
    DATA i_clienttype TYPE /ensx/clienttype.
    DATA i_cid        TYPE /ensx/firmenid.

    super->constructor( ).

    CREATE OBJECT go_friendlyfields
      EXPORTING
        i_objtype = bus_obj
*       i_clienttype = i_clienttype
        i_cid     = i_cid.
    m_objname = bus_obj.
  ENDMETHOD.


  METHOD _get_element_name.
    DATA: flddescr  TYPE dfies.
    DATA: elemdescr TYPE REF TO cl_abap_elemdescr.
    DATA: l_name    TYPE string.
    DATA: no_mixed  TYPE boole_d.
    TRY.
        super->_get_element_name(
          EXPORTING
            typedescr = typedescr
            path      = path
          RECEIVING
            name      = name
               ).

        l_name = me->_get_friemdly_fieldname(
            fieldname    = name
            path         = path
               ).
        IF l_name IS NOT INITIAL.
          name = l_name.
          no_mixed = abap_true.
        ELSEIF typedescr->is_ddic_type( ) = abap_true
          AND is_table_line = abap_true.
          elemdescr ?= typedescr.
          flddescr = elemdescr->get_ddic_field( ).
          IF flddescr-scrtext_l IS NOT INITIAL.
            name = flddescr-scrtext_l.
          ENDIF.
        ENDIF.
        name = /ensx/cl_abap_string_functions=>_replace_special_chars( in = name ).
        IF name(1) CA '1234567890'.
          CONCATENATE 't' name INTO name.
        ENDIF.
        TRANSLATE name USING ' _'.
        IF name CS '_' or no_mixed = abap_false.
          name = /ensx/cl_abap_string_functions=>_to_mixed(
              in        = name
                 ).
        ENDIF.
        CONDENSE name NO-GAPS.
      CATCH /ensx/cx_xslt .
    ENDTRY.
  ENDMETHOD.


  METHOD _GET_FRIEMDLY_FIELDNAME.
    DATA: base      TYPE string.
    DATA: recordset TYPE string.
    DATA: record    TYPE string.
    SPLIT path AT '.' INTO base recordset record.

    friendlyname = go_friendlyfields->/ensx/if_object_fldmap~get_friendly_fieldname(
        i_recordset      = recordset
        i_record         = record
        i_field          = fieldname
           ).

  ENDMETHOD.


  METHOD __check_flatten_condition.
    IF flatten = abap_true AND ( name = 'HEADER' OR name = 'ADDRESS' OR name = 'SEARCHRESULT' ).
      do_flatten = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.