#  www/[ec_url_concat [ec_url] /admin]/products/search.tcl
ad_page_contract {
  Search for a product based on name or sku.

  @author Eve Andersson (eveander@arsdigita.com)
  @author Bart Teeuwisse (bart.teeuwisse@thecodemill.biz)
  @creation-date Summer 1999
  @cvs-id $Id$
  @author ported by Jerry Asher (jerry@theashergroup.com)
} {
  sku:notnull,optional
  product_name:optional
}

ad_require_permission [ad_conn package_id] admin

if { [info exists sku] } {
    set additional_query_part "sku=:sku"
    set description "Products with SKU #$sku:"
} else {
    set product_name_search $product_name
    set additional_query_part "upper(product_name) like '%' || upper(:product_name_search) || '%'"
    set description "Products whose name includes \"$product_name\":"
}

doc_body_append "[ad_admin_header "Product Search"]

<h2>Product Search</h2>

[ad_context_bar [list "../" "Ecommerce([ec_system_name])"] [list "index.tcl" "Products"] "Product Search"]

<hr>

$description

<ul>
"

set product_counter 0
db_foreach product_search_select "select product_id, product_name from ec_products where $additional_query_part" {
    incr product_counter
    doc_body_append "<li><a href=\"one?[export_url_vars product_id]\">$product_name</a>\n"
} if_no_rows {
    doc_body_append "No matching products were found.\n"
}

doc_body_append "</ul>

[ad_admin_footer]
"
