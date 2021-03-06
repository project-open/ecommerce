<?xml version="1.0"?>

<queryset>
  <rdbms>
    <type>oracle</type>
    <version>8.1.6</version>
  </rdbms>

  <partialquery name="search_category">      
    <querytext>
      select p.product_name, p.product_id, p.dirname, 
          p.one_line_description,pseudo_contains(p.product_name || p.one_line_description || p.detailed_description || p.search_keywords, :search_text) as score
      from ec_products_searchable p, ec_category_product_map c
      where c.category_id=:category_id
      and p.product_id=c.product_id
      and pseudo_contains(p.product_name || p.one_line_description ||  p.detailed_description || p.search_keywords, :search_text) > 0
      order by score desc
    </querytext>
  </partialquery>

  <partialquery name="search_subcategory">      
    <querytext>
      select p.product_name, p.product_id, p.dirname, 
          p.one_line_description,pseudo_contains(p.product_name || p.one_line_description || p.detailed_description || p.search_keywords, :search_text) as score
      from ec_products_searchable p, ec_subcategory_product_map c
      where c.subcategory_id=:subcategory_id
      and p.product_id=c.product_id
      and pseudo_contains(p.product_name || p.one_line_description ||  p.detailed_description || p.search_keywords, :search_text) > 0
      order by score desc
    </querytext>
  </partialquery>

  <partialquery name="search_all">      
    <querytext>
      select p.product_name, p.product_id, p.dirname, 
          p.one_line_description,pseudo_contains(p.product_name || p.one_line_description || p.detailed_description || p.search_keywords, :search_text) as score
      from ec_products_searchable p
      where pseudo_contains(p.product_name || p.one_line_description ||  p.detailed_description || p.search_keywords, :search_text) > 0
      order by score desc
    </querytext>
  </partialquery>

</queryset>
