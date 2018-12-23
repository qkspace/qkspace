class AddProjectIdToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :project_id, :integer
  end
end
