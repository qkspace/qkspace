class CreateThreadedItems < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'ltree'

    create_table :threaded_items do |t|
      t.references :user, foreign_key: true
      t.references :page, foreign_key: true

      t.text :source
      t.text :html
      t.boolean :deleted, default: false
      t.ltree :path

      t.string :type

      t.timestamps
    end

    add_index :threaded_items, :path, using: :gist
  end
end
