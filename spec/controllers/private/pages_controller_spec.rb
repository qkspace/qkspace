require 'rails_helper'

describe Private::PagesController do
  before do
    @current_user = create(:user)
    allow(controller).to receive(:current_user).and_return(@current_user)
  end

  let!(:project) { FactoryBot.create(:project, owner: @current_user) }
  let!(:page) { FactoryBot.create(:page, project: project, title: "Test page") }

  describe '#show  api' do
    it 'show page by id' do
      get :show, format: :json, params: { project_id: project.id, id: page.id }

      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq "Test page"
    end
  end

  describe '#create api' do
    it 'create page by params' do
      post :create, format: :json, params: { project_id: project.id,
                                            page: { title: "create test title", source: "# Header!\r\ntext" }
      }

      expect(Page.where(title: "create test title")).to be
    end
  end

  describe '#update api' do
    it 'update page by params' do
      expect(page.title).to eq "Test page"

      put :update, format: :json, params: { project_id: project.id, id: page.id,
                                           page: { title: "New title", source: "# Header!\r\ntext" }
      }

      page.reload

      expect(page.title).to eq "New title"
      expect(page.source).to eq "# Header!\r\ntext"
      expect(Page.find_by(title: "Test page")).not_to be
    end
  end

  describe '#delete api' do
    it 'delete page' do
      expect(Page.all.length).to eq 2

      delete :destroy, format: :json, params: { project_id: project.id, id: page.id }

      expect(Page.all.length).to eq 1
      expect(Page.first.title).to eq project.title
    end
  end
end