# sort-custom.tcl,v 3.0 2000/02/06 03:54:43 ron Exp
#
# Takes the data generated from ad_table_sort_form function 
# and inserts into the user_custom table
#
# on succes it does an ad_returnredirect to return_url&$item_group=$item
#
# davis@xarg.net 20000105

ad_page_variables {item item_group return_url {delete_the_sort 0} {col -multiple-list} {dir -multiple-list} {item_original {}}}

set db [ns_db gethandle]
set user_id [ad_verify_and_get_user_id] 
ad_maybe_redirect_for_registration    
set item_type {table_sort}
set value_type {list}

if {$delete_the_sort && ![empty_string_p $item]} {
    util_dbq {item item_type value_type item_group}
    if {[catch {ns_db dml $db "delete user_custom
          where user_id = $user_id and item = $DBQitem and item_group = $DBQitem_group
            and item_type = $DBQitem_type"} errmsg]} {
        ad_return_complaint 1 "<li>I was unable to delete the sort.  The database said <pre>$errmsg</pre>\n"
        return
    }
    ad_returnredirect "$return_url"
    ad_script_abort
}

        
   
if {[empty_string_p $item]} {
    ad_return_complaint 1 "<li>You did not specify a name for this sort"
    ad_script_abort
}


set col_clean {}
set direction(asc) {}
set direction(desc) {*}

# Strip the blank columns...
set i 0 
foreach c $col {
    if {![empty_string_p $c]} {
        lappend col_clean "$c$direction([lindex $dir $i])"
    }
    incr i
}

if {[empty_string_p $col_clean]} {
    ad_return_complaint 1 "<li>You did not specify any columns to sort by"
    ad_script_abort
}

set col_clean [join $col_clean ","]

util_dbq {item item_original item_type value_type item_group}
with_transaction $db {
    ns_db dml $db "delete user_custom
      where user_id = $user_id and item = $DBQitem_original and item_group = $DBQitem_group
        and item_type = $DBQitem_type"

    ns_ora clob_dml $db "insert into user_custom (user_id, item, item_group, item_type, value_type, value)
      values ($user_id, $DBQitem, $DBQitem_group, $DBQitem_type, 'list', empty_clob())
      returning value into :1" $col_clean
} {
    ad_return_complaint 1 "<li>I was unable to insert your table customizations.  The database said <pre>$errmsg</pre>\n"
    ad_script_abort
}

ad_returnredirect "$return_url&$item_group=[ns_urlencode $item]"

