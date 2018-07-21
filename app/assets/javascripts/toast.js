//= require tui-code-snippet/dist/tui-code-snippet
//= require markdown-it/dist/markdown-it
//= require to-mark/dist/to-mark
//= require codemirror/lib/codemirror
//= require highlightjs/highlight.pack
//= require squire-rte/build/squire
//= require highlight.min
//= require tui-editor/dist/tui-editor-Editor.min
//= require tui-editor/dist/tui-editor-extScrollSync.min

// ToastUI load on specific page by "form_for" ID and submit text to textarea
$(document).on('turbolinks:load', function() {
    if ($("#form_for").length > 0) {
        var form = document.getElementById('form_for');
        var textarea = document.getElementById('toast_textarea');
        var editorElement = document.getElementById('editSection');

        var editor = new tui.Editor({
            el: editorElement,
            initialEditType: 'wysiwyg',
            previewStyle: 'tab',
            height: '320px'
        });
        form.addEventListener('submit', function () {
            textarea.value = editor.getValue();
        });
    }
});