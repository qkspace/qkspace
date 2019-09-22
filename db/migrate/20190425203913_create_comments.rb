class CreateComments < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'ltree'

    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :page
      t.integer :parent_id
      t.text :body
      t.boolean :deleted, default: false
      t.ltree :path

      t.timestamps
    end

    add_index :comments, :path, using: :gist
  end
end
