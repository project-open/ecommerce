<master>
  <property name="title">@package_instance_name@</property>
  <property name="context_bar">@context_bar;noquote@</property>

  <property name="show_toolbar_p">t</property>

    <blockquote>
      <if @user_is_logged_on@ true>
	Welcome back @user_name@!&nbsp;&nbsp;&nbsp;If you're not @user_name@, click <a href="@register_url@">here</a>
      </if>
      <else>
	Welcome!
      </else>

      <include src="browse-categories">

      <if @recommendations_if_there_are_any@>
	<h4>We recommend:</h4>
	@recommendations_if_there_are_any@
      </if>

      <if @products@>
	<h4>Products:</h4>
	@products;noquote@
      </if>

      @prev_link;noquote@ @separator@ @next_link;noquote@
    </blockquote>
