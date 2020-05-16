class RemoveDoubleIndexProjectIdForProjectCollaborations < ActiveRecord::Migration[5.2]
  def change
    remove_index :project_collaborations, column: :project_id, name: "index_project_collaborations_on_project_id"
  end
end
