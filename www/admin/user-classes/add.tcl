#  www/[ec_url_concat [ec_url] /admin]/user-classes/add.tcl
ad_page_contract {
    @param user_class_name

  @author
  @creation-date
  @cvs-id $Id$
  @author ported by Jerry Asher (jerry@theashergroup.com)
} {
    user_class_name:trim,notnull
}

ad_require_permission [ad_conn package_id] admin

set page_html "[ad_admin_header "Confirm New User Class"]

<h2>Confirm New User Class</h2>

[ad_context_bar [list "../" "Ecommerce([ec_system_name])"] [list "index.tcl" "User Classes"] "Confirm New User Class"]

<hr>

Add the following new user class?

<blockquote>
<code>$user_class_name</code>
</blockquote>
"


set user_class_id [db_nextval ec_user_class_id_sequence]

append page_html "<form method=post action=add-2>
[export_form_vars user_class_name user_class_id]
<center>
<input type=submit value=\"Yes\">
</center>
</form>

[ad_admin_footer]
"


doc_return  200 text/html $page_html