require File.expand_path("#{Rails.root}/app/workers/og_image_worker.rb")

namespace :og_images do
  desc "Generating OpenGraph Images for existing pages"
  task generate: :environment do
    pages = Page.all

    pages.each { |page| OgImageWorker.perform_async(page.project_id, page.id, page.title) }
  end
end
