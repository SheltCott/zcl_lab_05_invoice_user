CLASS zcl_lab_05_invoice_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    DATA: mv_exercise          TYPE n LENGTH 4,
          mv_invoice_no        TYPE n LENGTH 8,
          mv_invoice_code      TYPE string,
          mt_employees         TYPE TABLE OF zemp_logali,
          mv_case1             TYPE string,
          mv_case2             TYPE string,
          mv_data              TYPE string,
          mv_id_customer       TYPE string,
          mv_customer          TYPE string,
          mv_year              TYPE string,
          mv_invoice_num       TYPE string,
          mv_response          TYPE string,
          mv_count             TYPE i,
          mv_translate_invoice TYPE string VALUE 'Report the issuance of this invoice',
         
    METHODS concatenate_variables IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS concatenate_table_lines IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS condense_strings IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS split_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS shift_string IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS strlen_numofchar IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS translate_case IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_reverse IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.

      PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_05_invoice_user IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
********************First part**************************************************
*    Concatenation
    me->concatenate_variables( out ).

*    Concatenate table lines
    me->concatenate_table_lines( out ).

*    Condensation
    me->condense_strings( out ).

*    SPLIT
    me->split_string( out ).

*    SHIFT
    me->shift_string( out ).

*    STRLEN and NUMOFCHAR functions
    me->strlen_numofchar( out ).

*    TO_LOWER and TO_UPPER functions
    me->translate_case( out ).

*    INSERT and REVERSE functions
    me->insert_reverse( out ).

  ENDMETHOD.

  METHOD concatenate_variables.
*     Assign values to variables
    me->mv_exercise = '1234'.
    me->mv_invoice_no = '56789012'.

*     Concatenate variables
    me->mv_invoice_code = |{ me->mv_exercise }/{ me->mv_invoice_no }|.
    ir_out->write( |{ me->mv_invoice_code }| ).
  ENDMETHOD.

  METHOD concatenate_table_lines.
*     Dynamic query to the ZEMP_LOGALI table
    SELECT * FROM zemp_logali
        INTO TABLE me->mt_employees.

*     Concatenate table lines with a space
    DATA(lv_employees_string) = concat_lines_of( table = me->mt_employees sep = ' ' ).
    ir_out->write( |{ lv_employees_string }| ).
  ENDMETHOD.

  METHOD condense_strings.
*     Assign values to variables
    me->mv_case1 = 'Sales invoice with          status in process'.
    me->mv_case2 = '***ABAP*Cloud***'.

*     Remove spaces
    me->mv_case1 = condense( val = me->mv_case1 ).
    ir_out->write( |{ me->mv_case1 }| ).

*     Remove asterisks
    me->mv_case2 = condense( val = me->mv_case2 del = '*' ).
    ir_out->write( |{ me->mv_case2 }| ).
  ENDMETHOD.

  METHOD split_string.
*     Assign value to variable
    me->mv_data = '0001111111;LOGALI GROUP;2024'.

*     Split the string
    SPLIT me->mv_data AT ';' INTO me->mv_id_customer me->mv_customer me->mv_year.
    ir_out->write( |{ me->mv_id_customer }| ).
    ir_out->write( |{ me->mv_customer }| ).
    ir_out->write( |{ me->mv_year }| ).
  ENDMETHOD.

  METHOD shift_string.
*     Assign value to variable
    me->mv_invoice_num = '2015ABCD'.

*     Remove characters at the beginning and end
    me->mv_invoice_num = shift_left( val = me->mv_invoice_num places = 2 ).
    me->mv_invoice_num = shift_right( val = me->mv_invoice_num places = 2 ).
    ir_out->write( |{ me->mv_invoice_num }| ).
  ENDMETHOD.

  METHOD strlen_numofchar.
*     Assign value to variable
    me->mv_response = ' Generating Invoice '.
    ir_out->write( | { me->mv_response }| ).

*     Show length before removing spaces
    me->mv_count = strlen( |{ me->mv_response }| ).
    ir_out->write( |Length before: { me->mv_count }| ).

*     Remove spaces
    me->mv_count = numofchar( |{ me->mv_response }| ).
    ir_out->write( |Length after: { me->mv_count }| ).
  ENDMETHOD.

  METHOD translate_case.
*     Convert to uppercase
    ir_out->write( |Uppercase: { to_upper( me->mv_translate_invoice ) }| ).

*     Convert to lowercase
    ir_out->write( |Lowercase: { to_lower( me->mv_translate_invoice ) }| ).
  ENDMETHOD.

  METHOD insert_reverse.
*     Move the string " to client" to the end
    me->mv_translate_invoice = insert( val = me->mv_translate_invoice sub = ' to client' off = 35  ).

    ir_out->write( |{ me->mv_translate_invoice }| ).

*     Reverse the string
    me->mv_translate_invoice = reverse( me->mv_translate_invoice ).
    ir_out->write( |{ me->mv_translate_invoice }| ).
  ENDMETHOD.
  
ENDCLASS.