<master>
  <property name="title">Your Shopping Cart</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="signatory">@ec_system_owner;noquote@</property>

  <property name="show_toolbar_p">t</property>
  <property name="current_location">shopping-cart</property>

<if @user_id@ ne 0>
  for @first_names@ @last_name@ (if you're not @first_names@ @last_name@, 
  <a href=/register/>click here</a>).
</if>

<blockquote>
  <multiple name="in_cart">
    <if @in_cart.rownum@ eq 1>
       <form method=post action=shopping-cart-quantities-change>

           <table border="0" cellspacing="0" cellpadding="5" align="center">
             <tr bgcolor="#cccccc">
               <td>Item Description</td>
               <td>Options</td>
               <td>Quantity</td>
               <td>Price/Item</td>
<if @product_counter@ gt 1> <td>Subtotal</td> </if>
               <td>Action</td>
             </tr>
    </if>
    <tr>
      <td>
        <a href="product?product_id=@in_cart.product_id@">@in_cart.product_name@</a>
      </td>
      <td>
        <if @in_cart.color_choice@ not nil>
	  Color: @in_cart.color_choice@
	</if>
        <if @in_cart.size_choice@ not nil>
	  <br>Size: @in_cart.size_choice@
	</if>
        <if @in_cart.style_choice@ not nil>
	  <br>Style: @in_cart.style_choice@
	</if>
      </td>
      <td>
        <input type="text" 
	       name="quantity.@in_cart.product_id@ {@in_cart.color_choice@} {@in_cart.size_choice@} {@in_cart.style_choice@}" 
	       value="@in_cart.quantity@" size="@max_quantity_length@" maxlength="@max_quantity_length@">
      </td>
      <td>@in_cart.price;noquote@</td>
<if @product_counter@ gt 1><td align="right">@in_cart.line_subtotal@</td>
</if>
      <td>
        <a href="shopping-cart-delete-from?@in_cart.delete_export_vars@">delete</a>
      </td>
    </tr>
  </multiple>
  
  <if @product_counter@ ne 0>
    <tr bgcolor="#cccccc">
      <td colspan="2" align="right">Total:</td>
      <td>@product_counter@</td>
<if @product_counter@ gt 1><td bgcolor="#cccccc">&nbsp;</td>
</if>
      <td align="right">@pretty_total_price@</td>
      <td><input type=submit value="update"></td>
    </tr>
    <multiple name="tax_entries">
      <tr>
        <td colspan="5">
	  Residents of @tax_entries.state@, please add @tax_entries.pretty_tax@ tax.
	</td>
      </tr>
    </multiple>
    </table>

    </form>

    <center>
      <form method=post action="checkout-one-form">
        <input type=submit value="Proceed to Checkout"><br>
      </form>
    </center>
  </if>
  <else>
    <center>Your Shopping Cart is empty.</center>
  </else>

  <ul>
    <if @previous_product_id_p@ eq 1>
      <li> <a href="product?product_id=@previous_product_id@">Continue Shopping</a> </li>
    </if>
    <else>
      <li> <a href="index">Continue Shopping</a> </li>
    </else>
    <if @user_id@ eq 0>
      <li> <a href="/register/index?return_url=@return_url@">Log In</a> </li>
    </if>
    <else>
      <if @saved_carts_p@ not nil>
        <li><a href="shopping-cart-retrieve-2">Retrieve a Saved Cart</a> </li>
      </if>
    </else>

    <if @product_counter@ ne 0>
      <li><a href="shopping-cart-save">Save Your Cart for Later</a> </li>
    </if>
  </ul>
</blockquote>
