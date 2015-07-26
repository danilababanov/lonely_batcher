module LonelyBatcher
  class NavigationBuilder < RSLT::Stylesheet
    def rules
      render('taxonomies')               { builder.div { child_content } }
      render('taxonomies > taxonomy')    { child_content }
      render('taxonomy > taxonomy_name') { child_content }
      render('taxonomy > node')          { builder.ul(class: 'navigation') { child_content } }
      render('node > node')              { builder.ul { child_content } }
      render('node > node_name')         {
                                           builder.li {
                                             url = element.parent.xpath('@atlas_node_id').text + ".html"
                                             builder.a(href: url )  { add element.text }
                                                      }
                                         }
      render('text()')                   { add element }
    end
  end
end
