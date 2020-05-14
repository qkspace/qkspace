class RemoveDoubleIndexUserIdForSessions < ActiveRecord::Migration[5.2]
  def change
    remove_index :sessions, column: :user_id, name: "authenticatable"
  end
end
