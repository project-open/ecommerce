# /www/[ec_url_concat [ec_url] /admin]/cat/subcategory.tcl
ad_page_contract {

    @param category_id the ID of the category
    @param category_name the name of the category
    @param subcategory_id the ID of this subcategory
    @param subcategory_name the name of this subcategory

    @cvs-id $Id$
    @author ported by Jerry Asher (jerry@theashergroup.com)
} {
    category_id:integer,notnull
    category_name:notnull
    subcategory_id:integer,notnull
    subcategory_name:notnull
}

ad_require_permission [ad_conn package_id] admin

set page_html "[ad_admin_header "Subcategory: $subcategory_name"]

<h2>Subcategory: $subcategory_name</h2>

[ad_context_bar [list "../" "Ecommerce([ec_system_name])"] [list "index" "Categories &amp; Subcategories"] [list "category?[export_url_vars category_id category_name]" $category_name] "One Subcategory"]

<hr>

<ul>

<form method=post action=subcategory-edit>
[export_form_vars category_id category_name subcategory_id]
<li>Change subcategory name to:
<input type=text name=subcategory_name size=30 value=\"[ad_quotehtml $subcategory_name]\">
<input type=submit value=\"Change\">
</form>

<p>

<li><a href=\"../products/one-subcategory?[export_url_vars category_id category_name subcategory_id subcategory_name]\">View all products in this subcategory</a>

<p>

<li><a href=\"subcategory-delete?[export_url_vars category_id category_name subcategory_id subcategory_name]\">Delete this subcategory</a>

<p>
"

# Set audit variables
# audit_name, audit_id, audit_id_column, return_url, audit_tables, main_tables
set audit_name "$subcategory_name"
set audit_id $subcategory_id
set audit_id_column "subcategory_id"
set return_url "subcategory?[export_url_vars subcategory_id subcategory_name]"
set audit_tables [list ec_subcategories_audit ec_subsubcategories_audit ec_subcat_prod_map_audit]
set main_tables [list ec_subcategories ec_subsubcategories ec_subcategory_product_map]

append page_html "<li><a href=\"[ec_url_concat [ec_url] /admin]/audit?[export_url_vars audit_name audit_id audit_id_column return_url audit_tables main_tables]\">Audit Trail</a>

</ul>

<h3>Current Subsubcategories of $subcategory_name</h3>

<table>
"
set old_subsubcategory_id ""
set old_sort_key ""
set subsubcategory_counter 0

db_foreach get_subcategory_infos "select subsubcategory_id, sort_key, subsubcategory_name from ec_subsubcategories where subcategory_id=:subcategory_id order by sort_key" {

    incr subsubcategory_counter

    if { ![empty_string_p $old_subsubcategory_id] } {
	append page_html "<td> &nbsp;&nbsp;<font face=\"MS Sans Serif, arial,helvetica\"  size=1><a href=\"subsubcategory-add-0?[export_url_vars category_id category_name subcategory_id subcategory_name]&prev_sort_key=$old_sort_key&next_sort_key=$sort_key\">insert after</a> &nbsp;&nbsp; <a href=\"subsubcategory-swap?[export_url_vars category_id category_name subcategory_id subcategory_name]&subsubcategory_id=$old_subsubcategory_id&next_subsubcategory_id=$subsubcategory_id&sort_key=$old_sort_key&next_sort_key=$sort_key\">swap with next</a></font></td></tr>"
    }
    set old_subsubcategory_id $subsubcategory_id
    set old_sort_key $sort_key
    append page_html "<tr><td>$subsubcategory_counter. <a href=\"subsubcategory?[export_url_vars category_id category_name subcategory_id subcategory_name subsubcategory_id subsubcategory_name]\">$subsubcategory_name</a></td>\n"
}

if { $subsubcategory_counter != 0 } {
    append page_html "<td> &nbsp;&nbsp;<font face=\"MS Sans Serif, arial,helvetica\"  size=1><a href=\"subsubcategory-add-0?[export_url_vars category_id category_name subcategory_id subcategory_name]&prev_sort_key=$old_sort_key&next_sort_key=[expr $old_sort_key + 2]\">insert after</a></font></td></tr>
    "
} else {
    append page_html "You haven't set up any subsubcategories.  <a href=\"subsubcategory-add-0?[export_url_vars category_id category_name subcategory_id subcategory_name]&prev_sort_key=1&next_sort_key=2\">Add a subsubcategory.</a>\n"
}

append page_html "</table>
[ad_admin_footer]
"


doc_return  200 text/html $page_html
