namespace :og_images do
  desc "Generating OpenGraph Images for existing pages"
  task generate: :environment do
    generated_count = 0

    pages = Page.all

    puts  "Processing #{pages.size} pages"

    pages.find_each.with_index do |page, index|
      service = OgImageService.new(page.project_id, page.id, page.title)

      image = "#{service.og_image_path}/og-image.jpg"

      unless File.exist?(image)
        service.generate

        generated_count += 1
      end

      puts "Processing #{index} of #{pages.size}" if (index % 25).zero?
    end

    puts "Processing complete."
    puts "Images count: 109"
    puts "Images generated: #{generated_count}" if generated_count.positive?
  end
end
