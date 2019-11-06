require 'rails_helper'

describe MistakeController, :type => :request do
  before { ActionMailer::Base.deliveries = [] }

  # let(:text_msg) { 'Mistake is here!' }
  # let(:url) { 'qwerty.qkspace.com' }
  # let(:authors) { [['userone@mail.ru'], ['usertwo@mail.ru']] }
  # let(:title) { 'Reactive' }

  describe '#create' do
    
    text_msg = 'Mistake is here!'
    url = 'qwerty.qkspace.com'
    authors = [['userone@mail.ru'], ['usertwo@mail.ru']]
    title = 'Reactive'

    it 'sends text message for projects owner and collaborators' do
      # controller.send(:set_project)
      # controller.request.host = 'qwerty.qkspace.com'
      
      host! 'qwerty.qkspace.com:3000/'
      @project = 'qwerty'
      
      request = lambda do
        # post '/send_mistake', params: {
        post :send_mistake, params: {
          mistake: { url: url,
                     content: text_msg }
        }
      end
      
      expect(request).to change { ActionMailer::Base.deliveries.count }.by(2)

      mail = ActionMailer::Base.deliveries.first
      mail2 = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq 'userone@mail.ru'
      expect(mail2.to).to eq 'usertwo@mail.ru'

      expect(mail.body.to_s).to match(/http:\/\/.*\/send_mistake\/.*/)
      byebug
    end
  end
end
