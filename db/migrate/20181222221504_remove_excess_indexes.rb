class RemoveExcessIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :project_collaborations, name: "index_project_collaborations_on_project_id"
    remove_index :sessions, name: "authenticatable"
  end
end
