class /ENSX/CL_XSLT_XML_RENDERER definition
  public
  inheriting from /ENSX/CL_XSLT_BASE_RENDERER
  create public .

public section.

  methods _ADD_SIMPLE_ELEMENT
    redefinition .
  methods _ADD_STRUCTURE_ELEMENT_END
    redefinition .
  methods _ADD_STRUCTURE_ELEMENT_START
    redefinition .
  methods _ADD_TABLE_ELEMENT_END
    redefinition .
  methods _ADD_TABLE_ELEMENT_START
    redefinition .
  methods _DO_FOOTER
    redefinition .
  methods _DO_OBJECT_END
    redefinition .
  methods _DO_OBJECT_START
    redefinition .
  methods _ADD_BOOLEAN_ELEMENT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /ENSX/CL_XSLT_XML_RENDERER IMPLEMENTATION.


  method _ADD_BOOLEAN_ELEMENT.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.
    DATA: l_name         TYPE string.

    IF is_table_line = abap_false.
      l_name = path+1.
    ELSE.
      l_name = name.
    ENDIF.
    add_st_cond_start.
    IF is_funny = abap_false.
      add_st_scond_check_start l_name.
    ENDIF.
    IF is_table_line = abap_false.
      IF is_relative = abap_true.
        add_st_component_value_ref attribute_name l_name.
      ELSE.
        add_st_component_value_ref attribute_name path.
      ENDIF.
    ELSE.
      IF is_funny = abap_false.
        add_st_component_value_ref attribute_name name.
      ELSE.
        add_st_component_value_ref attribute_name 'TABLE_LINE'.
      ENDIF.
    ENDIF.
    IF is_funny = abap_false.
      add_st_cond_end name.
    ENDIF.
    add_st_cond_end name.
  endmethod.


  METHOD _add_simple_element.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.
    DATA: l_name         TYPE string.

    IF is_table_line = abap_false.
      l_name = path+1.
    ELSE.
      l_name = name.
    ENDIF.
    add_st_cond_start.
    IF is_funny = abap_false.
      add_st_scond_check_start l_name.
    ENDIF.
    IF is_table_line = abap_false.
      IF is_relative = abap_true.
        add_st_component_value_ref attribute_name l_name.
      ELSE.
        add_st_component_value_ref attribute_name path.
      ENDIF.
    ELSE.
      IF is_funny = abap_false.
        add_st_component_value_ref attribute_name name.
      ELSE.
        CONCATENATE '$' name into l_name.
        add_st_component_value_ref attribute_name l_name.
      ENDIF.
    ENDIF.
    IF is_funny = abap_false.
      add_st_cond_end name.
    ENDIF.
    add_st_cond_end name.
  ENDMETHOD.


  method _ADD_STRUCTURE_ELEMENT_END.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_component_end name.

  endmethod.


  method _ADD_STRUCTURE_ELEMENT_START.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_component_start name.

  endmethod.


  METHOD _add_table_element_end.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_table_end.
    add_st_component_end attribute_name.
    add_st_cond_end name.
  ENDMETHOD.


  METHOD _add_table_element_start.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.
    add_st_cond_start.
    add_st_component_start attribute_name.
    add_st_table_start  path name.
  ENDMETHOD.


  method _DO_FOOTER.
    DATA: lv_initial  TYPE boole_d.
    DATA: lv_comment  TYPE string.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_main_template_end.
    add_st_footer.
  endmethod.


  method _DO_OBJECT_END.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_component_end root.
  endmethod.


  method _DO_OBJECT_START.
    DATA: lv_lin         TYPE string.
    DATA: lv_src         TYPE string.
    DATA: lv_par         TYPE string.

    add_st_component_start root.
  endmethod.
ENDCLASS.