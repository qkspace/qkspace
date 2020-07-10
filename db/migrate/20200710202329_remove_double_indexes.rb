class RemoveDoubleIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :sessions, column: :user_id, name: "authenticatable"
    remove_index :project_collaborations, column: :user_id, name: "index_project_collaborations_on_user_id"
    remove_index :project_collaborations, column: :project_id, name: "index_project_collaborations_on_project_id"
  end
end
