class MarkdownInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    "<div class='edit-section'></div>" +
      @builder.text_area(attribute_name, class: 'toast-textarea', rows: 10, style: 'display: none')
  end
end
