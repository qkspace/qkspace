require 'commonmarker'

class HeadersRenderer < CommonMarker::HtmlRenderer
  def initialize(*args)
    @headers_counter = Hash.new(0)
    super(*args)
  end

  def header(node)
    block do
      out("<h", node.header_level, " id=\"", header_id(header_from_node(node)),
          "\">", :children, "</h", node.header_level, ">")
    end
  end

  private

  def header_from_node(node)
    I18n.
      transliterate(node.first_child.string_content, locale: :ru).
      parameterize.
      presence
  end

  def header_id(id)
    @headers_counter[id] += 1
    count = @headers_counter[id]

    return header_id("#{id}-#{count}") if count != 1

    id
  end
end
