<master>
  <property name="title">Retrieve Shopping Cart</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="signatory">@ec_system_owner;noquote@</property>

  <property name="show_toolbar_p">t</property>
  <property name="current_location">shopping-cart</property>

<blockquote>
  <p>We think that you are @user_name@.  If not, please <a
  href="@register_link@">log in</a>.</p>
  <p>Otherwise,</p>
  <form method=post action="shopping-cart-retrieve-2">
    <center>
      <input type=submit value="Continue">
    </center>
  </form>
</blockquote>
