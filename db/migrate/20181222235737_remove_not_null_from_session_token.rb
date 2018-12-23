class RemoveNotNullFromSessionToken < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sessions, :token, true
  end
end
