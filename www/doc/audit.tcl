ad_page_contract {

    Audit documentation of the ecommerce package, a
    package to implement business-to-consumer web services.

    @author Bart Teeuwisse (bart.teeuwisse@thecodemill.biz)
    @creation-date May 2002

} {
} -properties {
    title:onevalue
    context_bar:onevalue
}

# Authenticate the user

set user_id [ad_maybe_redirect_for_registration]

# Check for read privileges

set package_id [ad_conn package_id]
set admin_p [ad_permission_p $package_id read]

set package_name "Ecommerce"
set title "$package_name Documentation: Auditing"
set package_url [apm_package_url_from_key "ecommerce"]

# Set the context bar.

set context_bar [ad_context_bar [list "." "$package_name"] "Auditing"]

# Set signatory for at the bottom of the page

set signatory "bart.teeuwisse@thecodemill.biz"
