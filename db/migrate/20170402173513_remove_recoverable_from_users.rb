class RemoveRecoverableFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
  end

  def down
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
  end
end
