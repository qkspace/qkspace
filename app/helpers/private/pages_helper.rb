module Private::PagesHelper
  def markdown_hint_link
    href = link_to t('views.markdown.hint_a'), '#', data: {
      toggle: 'modal',
      target: '#markdown-modal-window'
    }
    t('views.markdown.hint_link', href: href).html_safe
  end
end
