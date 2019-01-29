require 'commonmarker'

class HeadersRenderer < CommonMarker::HtmlRenderer
  def header(node)
    block do
      out("<h", node.header_level, " id=\"", I18n.transliterate(node.first_child.string_content, :locale => :ru).parameterize.presence,
          "\">", :children, "</h", node.header_level, ">")
    end
  end
end