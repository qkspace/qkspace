require 'commonmarker'

class HeadersRenderer < CommonMarker::HtmlRenderer
  def initialize(*args)
    @headers_counter = Hash.new(0)
    super(*args)
  end

  def header(node)
    block do
      out("<h", node.header_level, " id=\"", header_id(node),
          "\">", :children, "</h", node.header_level, ">")
    end
  end

  private

  def header_id(node)
    id = I18n.
      transliterate(node.first_child.string_content, locale: :ru).
      parameterize.
      presence

    id << "-#{@headers_counter[id] + 1}" if @headers_counter[id] != 0

    @headers_counter[id] += 1

    id
  end
end
