class /ENSX/CX_XSLT definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  data ERRORS type O2XSLTERRT .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !ERRORS type O2XSLTERRT optional .
  methods GET_XSLT_ERRORS
    returning
      value(ERRORS) type O2XSLTERRT .
protected section.
private section.
ENDCLASS.



CLASS /ENSX/CX_XSLT IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->ERRORS = ERRORS .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  method GET_XSLT_ERRORS.
    errors = errors.
  endmethod.
ENDCLASS.