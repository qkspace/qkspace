module BlocksHelper
  def markdown_hint_link
    href = link_to t('blocks.markdown_hint_a'), '#', data: {
      component: 'modal',
      target: '#block-source-help'
    }
    t('blocks.markdown_hint_link', href: href).html_safe
  end

  def markdown_hint
    t('blocks.markdown_hint_link', href: t('blocks.markdown_hint_a'))
  end

  def markdown_partial
    render partial: 'partials/md_help'
  end
end
