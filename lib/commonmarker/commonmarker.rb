require 'commonmarker'

class MyHtmlRenderer < CommonMarker::HtmlRenderer
  def header(node)
    block do
      out("<h", node.header_level, " id=\"", I18n.transliterate(node.first_child.string_content).parameterize.presence,
          "\">", :children, "</h", node.header_level, ">")
    end
  end
end
