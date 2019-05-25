class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :page
      t.integer :parent_id
      t.text :body
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
