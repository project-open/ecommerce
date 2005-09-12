# /www/[ec_url_concat [ec_url] /admin]/orders/gift-certificate-void.tcl
ad_page_contract {

  Void a gift certificate.

  @author Eve Andersson (eveander@arsdigita.com)
  @creation-date Summer 1999
  @cvs-id $Id$
  @author ported by Jerry Asher (jerry@theashergroup.com)
} {
  gift_certificate_id:integer,notnull
}

ad_require_permission [ad_conn package_id] admin

set page_title "Void Gift Certificate"
doc_body_append "[ad_admin_header $page_title]
<h2>$page_title</h2>

[ad_context_bar [list "../index" "Ecommerce([ec_system_name])"] [list "index" "Orders"] [list "gift-certificates" "Gift Certificates"] "Void One"]

<hr>
Please explain why you are voiding this gift certificate:

<form method=post action=gift-certificate-void-2>
[export_form_vars gift_certificate_id]

<blockquote>
<textarea wrap name=reason_for_void rows=3 cols=50></textarea>
</blockquote>

<center>
<input type=submit value=\"Continue\">
</center>

</form>

[ad_admin_footer]
"
