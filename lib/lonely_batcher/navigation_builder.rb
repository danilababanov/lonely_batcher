
module LonelyBatcher
  class NavigationBuilder < RSLT::Stylesheet
    def rules
      render('taxonomies') { builder.div(id: 'sidebar') { child_content } }
      render('taxonomies > taxonomy') { builder.div(id: 'user-navigation' ) { child_content } }
      render('taxonomy > taxonomy_name') { builder.h3 { child_content } }
      render('taxonomy > node') { builder.ul { child_content } }
      render('node > node') { builder.ul { child_content } }
      render('node > node_name') { builder.li {  builder.a(href: element.text.downcase.gsub(' ', '_') )  { add element.text } } }
      render('text()') { add element }
    end
  end
end
