require 'rails_helper'

describe Private::ProjectCollaborationsController do
  before do
    @current_user = create(:user)
    allow(controller).to receive(:current_user).and_return(@current_user)
  end

  describe '#create' do
    before do
      @project = create(:project, owner: @current_user)
    end

    context 'invitee is registered' do
      before do
        @invitee = create(:user)

        @do_request = ->() {
          post :create, params: {
            project_id: @project.id,
            project_collaboration: {collaborator_email: @invitee.email}
          }
        }
      end

      it 'responds with redirect' do
        @do_request.()
        expect(response).to be_redirect
      end

      it 'creates ProjectCollaboration' do
        @do_request.()
        expect(ProjectCollaboration.where(user_id: @invitee.id, project_id: @project.id)).to exist
      end

      it 'sends email to invitee with project title and magic link' do
        expect(@do_request).to change { ActionMailer::Base.deliveries.count }.by(1)

        mail = ActionMailer::Base.deliveries.last

        expect(mail.subject).to include(@project.title)
        expect(mail.to).to eq [@invitee.email]
        expect(mail.body.to_s).to match(/http:\/\/.*\/sign_in\/.*/)
      end
    end

    context 'invitee is not registered' do
      before do
        @collaborator_email = "invited_user@example.org"
        @do_request = ->() {
          post :create, params: {
            project_id: @project.id,
            project_collaboration: {collaborator_email: @collaborator_email}
          }
        }
      end

      it 'responds with redirect' do
        @do_request.()
        expect(response).to be_redirect
      end

      it 'creates new User and a ProjectCollaboration' do
        expect(@do_request).to change { User.count }.by(1)

        invitee = User.where(email: @collaborator_email)
        expect(invitee).to exist
        invitee = invitee.first
        expect(invitee.email).to eq @collaborator_email

        expect(ProjectCollaboration.where(user: invitee, project_id: @project.id)).to exist
      end
    end
  end
end
