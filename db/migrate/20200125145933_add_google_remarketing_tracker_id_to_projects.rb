class AddGoogleRemarketingTrackerIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :google_remarketing_tracker_id, :string
  end
end
