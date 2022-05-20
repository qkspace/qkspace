require 'rails_helper'

describe Public::PagesController, type: :request do
  describe '#mistake_report' do
    let(:project) { create(:project, slug: 'super-project') }
    let(:page) { create(:page, project: project, title: 'super-page' ) }

    before(:all) { host! 'super-project.qkspace.com:3000' }
    subject { post mistake_report_public_page_path(slug: page.slug), params: params }

    context 'when params are not valid' do
      context 'and text is absent' do
        let(:params) do
          {
            mistake: {
              correction: 'Right text',
            }
          }
        end

        it 'does not send email' do
          expect { subject }.not_to change { ActionMailer::Base.deliveries.count }
        end
      end

      context 'and correction is absent' do
        let(:params) do
          {
            mistake: {
              text: 'Wrong text',
            }
          }
        end

        it 'does not send email' do
          expect { subject }.not_to change { ActionMailer::Base.deliveries.count }
        end
      end
    end

    context 'when params are valid' do
      let(:params) do
        {
          mistake: {
            text: 'Wrong text',
            correction: 'Right text',
          }
        }
      end

      it 'sends email' do
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)

        mail = ActionMailer::Base.deliveries.last

        expect(mail.subject).to include(project.title, page.title)
        expect(mail.body).to include(*params[:mistake].values)
        expect(mail.bcc).to eq [project.owner.email]
      end
    end
  end
end
