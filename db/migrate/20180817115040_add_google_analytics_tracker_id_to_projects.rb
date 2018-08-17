class AddGoogleAnalyticsTrackerIdToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :google_analytics_tracker_id, :string
  end
end
