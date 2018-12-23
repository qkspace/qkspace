class UpdateOldSessions < ActiveRecord::Migration[5.2]
  def change
    ApplicationRecord.connection.execute("
      UPDATE sessions
      SET type = 'Session::UserToken'
      WHERE type IS NULL
    ")
  end
end
