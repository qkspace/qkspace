require 'rails_helper'

RSpec.describe Page, type: :model do
  context 'markup' do
    let(:page_with_russian_headers) { create(:page, source: "# Привет, мир 2!\r\nHello, world!") }
    let(:page_with_english_headers) { create(:page, source: "# Hello, world 2!\r\nHello, world!") }
    let(:page_with_mix_headers) { create(:page, source: "# Hello, world 2!\r\n## Привет, мир 2!\r\nHello, world!") }
    let(:page_with_spoilers) { create(:page, source: "1. Question1\r\n<details>\r\n<summary>Answer</summary>\r\nthis is me, answer!\r\n</details>") }
    let(:page_with_same_headers) { create(:page, source: "# Hello, world!\n## Hello, world!") }

    it 'render headers with anchors' do
      expect(page_with_english_headers.html).to eq("<h1 id=\"hello-world-2\">Hello, world 2!</h1>\n<p>Hello, world!</p>\n")
    end

    it 'render headers in en locale' do
      I18n.locale = :en
      expect(page_with_russian_headers.html).to eq("<h1 id=\"privet-mir-2\">Привет, мир 2!</h1>\n<p>Hello, world!</p>\n")
      expect(I18n.locale).to eq :en # method doesn`t change current locale
    end

    it 'render headers with mix lang' do
      expect(page_with_mix_headers.html).to eq("<h1 id=\"hello-world-2\">Hello, world 2!</h1>\n<h2 id=\"privet-mir-2\">Привет, мир 2!</h2>\n<p>Hello, world!</p>\n")
    end

    it 'render html with spoilers' do
      expect(page_with_spoilers.html).to eq("<ol>\n<li>Question1</li>\n</ol>\n<details>\n<summary>Answer</summary>\nthis is me, answer!\n</details>\n")
    end

    it 'assigns different IDs to headers with the same text' do
      expect(page_with_same_headers.html).to eq "<h1 id=\"hello-world\">Hello, world!</h1>\n<h2 id=\"hello-world-2\">Hello, world!</h2>\n"
    end
  end
end
