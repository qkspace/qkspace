namespace :custom do
  desc "Concatenates blocks html & source fields to that fields of a page " \
    "owning these blocks"
  task copy_blocks_to_pages: :environment do
    Page.all.each do |page|
      page.source = page.blocks.map(&:source).join("\n\n")
      page.html = page.blocks.map(&:html).join("\n")
      page.save
    end
  end
end
