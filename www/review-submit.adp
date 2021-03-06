<master>
  <property name="title">Write Your Own Review of @product_name;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="signatory">@ec_system_owner;noquote@</property>

  <property name="show_toolbar_p">t</property>

<form method="post" action="review-submit-2">
  <input type="hidden" name="product_id" value="@product_id@">
  <ol>
    <li>
      <p>What is your rating of this product?</p>
      @rating_widget;noquote@
    </li>
    <li><p>Please enter a headline for your review:</p>
      <input type="text" size="50" name="one_line_summary">
      </li>
    <li>
      <p>Enter your review below: (maximum of 1,000 words)</p>
      <textarea wrap name="user_comment" rows="6" cols="50"></textarea>
    </li>
  </ol>
  <blockquote>
    <input type="submit" value="Preview your review">
  </blockquote>
</form>
