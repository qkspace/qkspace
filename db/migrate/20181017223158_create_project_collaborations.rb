class CreateProjectCollaborations < ActiveRecord::Migration[5.2]
  def change
    create_table :project_collaborations do |t|
      t.references :user, foreign_key: true, index: true
      t.references :project, foreign_key: true, index: true

      t.timestamps

      t.index [:project_id, :user_id], unique: true
    end
  end
end
