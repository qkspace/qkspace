class AddKindAndUserIdIndexToSessions < ActiveRecord::Migration[5.2]
  def change
    add_index :sessions, :user_id
    add_column :sessions, :type, :string
  end
end
