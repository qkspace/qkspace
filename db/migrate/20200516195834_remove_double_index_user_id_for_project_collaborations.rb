class RemoveDoubleIndexUserIdForProjectCollaborations < ActiveRecord::Migration[5.2]
  def change
    remove_index :project_collaborations, column: :user_id, name: "index_project_collaborations_on_user_id"
  end
end
