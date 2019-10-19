class AddThreadedItemsSettingsToProjects < ActiveRecord::Migration[5.2]
  def change
    change_table :projects do |t|
      t.boolean :discussions_enabled, default: false
      t.boolean :comments_enabled, default: false
      t.boolean :allow_unregistered_comments, default: false
    end
  end
end
