require 'rails_helper'

describe Private::ProjectsController do
  before do
    @current_user = create(:user)
    allow(controller).to receive(:current_user).and_return(@current_user)
  end

  describe '#redirect_to_public' do
    before do
      @project = create(:project, owner: @current_user, slug: "test-redirect")
    end

    it 'redirects to public sign in URL with token (subdomain)' do
      get :redirect_to_public, params: {id: @project.id}

      expect(response).to be_redirect
      expect(response.location).to match("http://test-redirect.qkspace.host/sign_in/.+")
    end

    it 'redirects to public sign in URL with token (TLD)' do
      @project.update_column(:domain, "test-redirect.example.org")

      get :redirect_to_public, params: {id: @project.id}

      expect(response).to be_redirect
      expect(response.location).to match("http://test-redirect.example.org/sign_in/.+")
    end

    it 'redirects with session token' do
      get :redirect_to_public, params: {id: @project.id}

      token = response.location.match("http://test-redirect.qkspace.host/sign_in/(.+)")[1]
      expect(Passwordless::Session.where(authenticatable: @current_user, token: token)).to exist
    end
  end
end
