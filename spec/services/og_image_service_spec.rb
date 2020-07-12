require 'rails_helper'

RSpec.describe OgImageService, type: :service do
  describe 'service creates images' do
    let(:pages) { create_list(:page, 5) }

    context 'before generate OGImage' do
      it 'returns false' do
        pages.each do |page|
          expect(File.exist?("#{Rails.root}/public/images/opengraph/test/#{page.project_id}/#{page.id}/og-image.jpg")).to be false
        end
      end
    end

    context 'after generate OGImage' do
      it 'returns true' do
        pages.each do |page|
          image = "#{Rails.root}/public/images/opengraph/test/#{page.project_id}/#{page.id}/og-image.jpg"

          OgImageService.new(page.project_id, page.id, page.title).generate

          expect(File.exist?(image)).to be true

          FileUtils.remove(image) if File.exist?(image)
        end
      end
    end
  end
end
