require 'rails_helper'

RSpec.describe Page, type: :model do
  context 'markup' do
    let(:page_with_russian_headers) { FactoryBot.create(:page, source: "# Привет, мир 2!\r\nHello, world!") }
    let(:page_with_spoilers) { FactoryBot.create(:page, source: "1. Question1\r\n    <details>\r\n      <summary>Answer</summary>\r\n      this is me, answer!\r\n    </details>") }

    it 'render headers with anchors' do
      expect(page_with_russian_headers.html).to eq("<h1 id=\"privet-mir-2\">Привет, мир 2!</h1>\n<p>Hello, world!</p>\n")
    end

    it 'render html with spoilers' do
      expect(page_with_spoilers.html).to eq("<ol>\n<li>Question1\n <details>\n   <summary>Answer</summary>\n   this is me, answer!\n </details>\n</li>\n</ol>\n")
    end
  end
end