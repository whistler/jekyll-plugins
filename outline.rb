# Jekyll filter to create an outline of a post by selecting the first paragraph 
# and all the h2s in a post
# Example:
# {{ post.content | outline }}

require 'rubygems'
require 'nokogiri'

module Jekyll
  module OutlineTag
    
    def outline(content)
      doc = Nokogiri::HTML(Iconv.conv('UTF8//TRANSLIT//IGNORE', 'UTF8', content))
      
      p = doc.xpath("//p").first.inner_html
      p = "<p>#{p}</p>" if p
      
      headings = doc.xpath("//h2")
                    .map{|h2| "<li>" + h2.text + "</li>"}
                    .join
      headings = "<ul>#{headings}</ul>" if headings != ""
      
      outline = p + headings
    end
    
  end
end

Liquid::Template.register_filter(Jekyll::OutlineTag)