const mistakeReport = () => {
  const selectedText = getSelectedText()

  if (!selectedText) {
    alert($('#mistake-report-instructions').text())
    return
  }

  $('#mistake-report-modal').modal('show')

  $('#mistake-report-modal-submit').on('click', () => {
    const mistakeReportForm = $('#mistake_report_form')

    const formData = mistakeReportForm.serializeArray()
    formData.push({ name: 'mistake[text]', value: selectedText })

    mistakeReportForm.trigger('reset')
    $('#mistake-report-modal').modal('hide')

    $.ajax({
      url: mistakeReportForm.attr('action'),
      data: $.param(formData),
      type: mistakeReportForm.attr('method'),
    })
  })
}

const getSelectedText = () => {
  if (window.getSelection) {
    return window.getSelection().toString()
  } else if (document.getSelection) {
    return document.getSelection()
  } else if (document.selection) {
    return document.selection.createRange().text
  }
}

window.mistakeReport = mistakeReport
window.getSelectedText = getSelectedText
