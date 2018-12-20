class ReformatSessions < ActiveRecord::Migration[5.2]
  def change
    rename_table :passwordless_sessions, :sessions

    change_table :sessions do |t|
      t.rename :authenticatable_id, :user_id
      t.remove :authenticatable_type
      t.boolean :active, default: true, null: false
      t.index :token, unique: true
    end

    change_column_null :sessions, :remote_addr, true
    change_column_null :sessions, :user_agent, true
  end
end
