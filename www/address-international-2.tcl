ad_page_contract {
    @param attn
    @param first_names
    @param last_name
    @param line1
    @param line2:optional
    @param city 
    @param full_state_name:optional
    @param zip_code:optional
    @param country_code
    @param phone
    @param phone_time:optional
    @param referer

    @author
    @creation-date
    @author ported by Jerry Asher (jerry@theashergroup.com)
    @author revised by Bart Teeuwisse (bart.teeuwisse@thecodemill.biz)
    @revision-date April 2002

} {
    address_type
    address_id:optional
    attn:optional
    first_names
    last_name
    line1:notnull
    line2:optional
    city:notnull
    full_state_name:optional
    zip_code:optional
    country_code:notnull
    phone
    {phone_time "d"}
    referer
}

set possible_exception_list [list [list first_names "first name"] [list last_name "last name"] [list line1 address] [list city city] [list country_code country] [list phone "telephone number"]]
set exception_count 0
set exception_text ""

foreach possible_exception $possible_exception_list {
    if { ![info exists [lindex $possible_exception 0]] || [empty_string_p [set [lindex $possible_exception 0]]] } {
	incr exception_count
	append exception_text "<li>You forgot to enter your [lindex $possible_exception 1].</li>"
    }
}

if { $exception_count > 0 } {
    ad_return_complaint $exception_count $exception_text
    ad_script_abort
}

# We need them to be logged in

set user_id [ad_verify_and_get_user_id]
if {$user_id == 0} {
    set return_url "[ad_conn url]?[export_entire_form_as_url_vars]"
    ad_returnredirect "/register?[export_url_vars return_url]"
    ad_script_abort
}

# Make sure they have an in_basket order, otherwise they've probably
# gotten here by pushing Back, so return them to index.tcl

set user_session_id [ec_get_user_session_id]
set order_id [db_string get_order_id "select order_id from ec_orders where user_session_id=:user_session_id and order_state='in_basket'" -default ""]
if { [empty_string_p $order_id] } {

    # Then they probably got here by pushing "Back", so just redirect
    # them to index.tcl

    rp_internal_redirect index
    ad_script_abort
}

# assuming all cases are billing, since shipping defaults as billing addrs
# if {$address_type == "billing"} {
# set attn from first_names and last_name 
# the 3 space delimiter may be used to parse names by specific payment gateway
# first clean out all multiple spaces 
    regsub -all { +} $first_names " " first_names
    regsub -all { +} $last_name " " last_name
    set attn "[string trim $first_names]   [string trim $last_name]"

if { [info exists address_id] && $address_id != "" } {

    # This is an existing address that has been edited.

    db_transaction {
	db_dml update_address "
	    update ec_addresses
    	    set attn = :attn, line1 = :line1, line2 = :line2, 
	        city = :city, full_state_name = :full_state_name, zip_code = :zip_code, country_code = :country_code, phone = :phone, phone_time = :phone_time
	    where address_id = :address_id"
	db_dml set_shipping_on_order "
	    update ec_orders 
	    set shipping_address = :address_id 
	    where order_id = :order_id"
    }
    db_release_unused_handles
} else {

    # This is a new address which requires an address_id.

    set address_id [db_nextval ec_address_id_sequence]

    db_transaction {
	db_dml insert_new_address "
	    insert into ec_addresses
    	    (address_id, user_id, address_type, attn, line1, line2, city, full_state_name, zip_code, country_code, phone, phone_time)
    	    values
    	    (:address_id, :user_id, 'shipping', :attn, :line1,:line2,:city,:full_state_name,:zip_code,:country_code,:phone,:phone_time)"
	db_dml update_order_shipping_address "
	    update ec_orders 
	    set shipping_address=:address_id 
	    where order_id=:order_id"
    }
    db_release_unused_handles
}

# Return to the calling page (E.g. checkout, billing,
# giftcertificate-billing).

rp_internal_redirect $referer
