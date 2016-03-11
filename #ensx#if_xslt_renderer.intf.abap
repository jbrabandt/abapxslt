interface /ENSX/IF_XSLT_RENDERER
  public .


  class /ENSX/CL_XSLT_BASE_RENDERER definition load .
  data GT_SOURCEBIND type /ENSX/CL_XSLT_BASE_RENDERER=>TY_TRANS_SRCBIND_TAB .

  methods RENDER
    importing
      !DREF type ref to DATA optional
      !DATA type DATA optional
      !ROOT type STRING optional
    returning
      value(XSLT) type STRING
    raising
      /ENSX/CX_XSLT .
  methods ADD_SOURCE
    importing
      !ROOT type STRING
      !DATA type DATA optional
      !DREF type ref to DATA optional
      !ADD_SKIP type BOOLE_D optional
      !FLATTEN type BOOLE_D optional
    raising
      /ENSX/CX_XSLT .
endinterface.