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
      expect(Session.where(user: @current_user, token: token)).to exist
    end
  end

  describe '#index api' do
    before do
      @project1 = create(:project, owner: @current_user, slug: "test1")
      @project2 = create(:project, owner: @current_user, slug: "test2")
      @project3 = create(:project, slug: "test3")
    end

    it 'show current_user projects' do
      get :index, format: :json

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['slug']).to eq "test1"
      expect(json_response.last['slug']).to eq "test2"
    end
  end

  describe '#show api' do
    before do
      @project = create(:project, owner: @current_user)
      @project2 = create(:project, owner: @current_user)
      @page1 = create(:page, project: @project, title: "Page 1")
      @page2 = create(:page, project: @project, title: "Page 2")
      @page3 = create(:page, project: @project2, title: "Page 3")
    end

    it 'show pages by project id' do
      get :show, format: :json, params: {id: @project.id}

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response.first['title']).to eq @project.title
      expect(json_response.last['title']).to eq 'Page 2'
    end
  end
end
