require "rails_helper"
    
RSpec.describe MistakeMailer, :type => :mailer do
  before { ActionMailer::Base.deliveries = [] }

  describe "send of finded mistake" do
    text_msg = 'Mistake is here!'
    url = 'qwerty.qkspace.com'
    authors = [['userone@mail.ru'], ['usertwo@mail.ru']]
    title = 'Reactive'
    locales = ["ru", "en"]
    
    mail = MistakeMailer.with(text_msg: text_msg,
                              url: url,
                              author: authors[0],
                              title: title,
                              locale: locales[0])
                              .mistake
                              .deliver
    mail2 = MistakeMailer.with(text_msg: text_msg,
                               url: url,
                               author: authors[1],
                               title: title,
                               locale: locales[1])
                               .mistake
                               .deliver

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

      expect(mail.html_part.body.raw_source).to include("Найдена ошибка")
    end
  end
end
