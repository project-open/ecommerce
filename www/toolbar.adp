      <p>
 <if @gift_certificates_are_allowed@ true and @current_location@ ne "gift-certificate"> 
    [&nbsp;<a href="@ec_gift_cert_order_link@">gift certificates</a>&nbsp;] 
 </if>
 <if @current_location@ ne "shopping-cart"> 
    [&nbsp;<a href="@ec_cart_link@" title="View the contents of your shopping cart">shopping cart</a>&nbsp;]
 </if>
 <if @current_location@ ne "your-account"> 
    [&nbsp;<a href="@ec_account_link@" title="View your @ec_system_name@ account">your @ec_system_name@ account</a>&nbsp;]
 </if>
      </p>

      @ec_search_widget;noquote@

