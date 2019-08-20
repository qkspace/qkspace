require "rails_helper"

RSpec.describe MistakeMailer, :type => :mailer do
  before { ActionMailer::Base.deliveries = [] }

  let(:text_msg) { 'Mistake is here!' }
  let(:url) { 'qwerty.qkspace.com' }
  let(:authors) { [['userone@mail.ru'], ['usertwo@mail.ru']] }
  let(:title) { 'Reactive' }

  describe "send of finded mistake" do
    let(:mail) { MistakeMailer.mistake(text_msg, url, authors[0], title).deliver_now }
    let(:mail2) { MistakeMailer.mistake(text_msg, url, authors[1], title).deliver_now }

    it "renders the sender email" do
      expect(mail.from).to eq(["no-reply@qkspace.com"])
    end

    it "renders the reciever email" do
      expect(mail.to).to eq(authors[0])
      expect(mail2.to).to eq(authors[1])
      expect(MistakeMailer.deliveries.size).to eq(2)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq("Найдена ошибка в проекте #{title}")
    end

    it 'renders the body' do
      expect(mail.to).to eq(authors[0])

      message = ActionMailer::Base.deliveries.last
      expect(message.html_part.body.to_s).to include('is here!')
    end
  end
end
