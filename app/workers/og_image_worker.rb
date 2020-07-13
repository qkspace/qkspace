class OgImageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project_id, page_id, page_title)
    OgImageService.new(project_id, page_id, page_title).generate
  end
end
