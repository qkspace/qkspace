require 'rails_helper'

describe Session::UserTokensController do
  before do
    @user = create(:user)
  end

  describe '#create' do
    it 'sends magic link for existing email' do
      request = lambda do
        post :create, params: {
          session: {email: @user.email}
        }
      end

      expect(request).to change { ActionMailer::Base.deliveries.count }.by(1).
        and change { Session.where(user: @user).count }.by(1)

      mail = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq [@user.email]
      expect(mail.parts.first.body.to_s).to match(/http:\/\/.*\/sign_in\/.*/)
    end

    it 'shows error for non-existing email' do
      request = lambda do
        post :create, params: {
          session: {email: "non-existing@example.org"}
        }
      end

      expect(request).to change { ActionMailer::Base.deliveries.count }.by(0).
        and change { Session.where(user: @user).count }.by(0)

      expect(flash[:alert]).to be
    end
  end

  describe '#show' do
    before do
      @session = Session::UserToken.create!(user: @user)
    end

    it 'logins via session token (magic link)' do
      expect(@session.token).to be

      get :show, params: {token: @session.token}

      current_user = controller.send(:current_user)
      expect(current_user).to eq @user
    end

    it "doesn't login with wrong token" do
      expect {get :show, params: {token: "login_me_plz"}}.to raise_error(ActiveRecord::RecordNotFound)

      current_user = controller.send(:current_user)
      expect(current_user).to be_nil
    end
  end
end
