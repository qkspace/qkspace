require 'rails_helper'

describe Session::ProjectSecretTokensController do
  before do
    @user = create(:user)
  end

  describe '#show' do
    before do
      @project = create(:project, secret_enabled: true, secret_token: 't0ken')
    end

    it 'logins via project token and creates a session' do
      expect {get :show, params: {token: @project.secret_token}}.
        to change {Session::ProjectSecretToken.where(project: @project).count}.by(1)

      current_user = controller.send(:current_user)
      expect(current_user).to be_a(AnonymousProjectReader)
    end

    it "doesn't login with wrong token" do
      expect {get :show, params: {token: "login_me_plz"}}.
        to raise_error(ActiveRecord::RecordNotFound)

      current_user = controller.send(:current_user)
      expect(current_user).to be_nil
    end

    it "doesn't login for project without secret_enabled" do
      @project.update_column(:secret_enabled, false)

      expect {get :show, params: {token: @project.secret_token}}.
        to raise_error(ActiveRecord::RecordNotFound)

      current_user = controller.send(:current_user)
      expect(current_user).to be_nil
    end
  end
end
