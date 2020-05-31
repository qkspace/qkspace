require "#{Rails.root}/app/workers/og_image_worker.rb"

namespace :og_images do
  desc "Generating OpenGraph Images for existing pages"
  task generate: :environment do
    pages = Page.all

    puts  "Processing #{pages.size} pages"

    pages.find_each.with_index do |page, index|
      OgImageWorker.new.perform(page.project_id, page.id, page.title)

      puts "Processing #{index} of #{pages.size}" if (index % 25).zero?
    end

    puts "\rProcessing complete. Generated #{pages.size} images."
  end
end
