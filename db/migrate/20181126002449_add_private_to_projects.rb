class AddPrivateToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :private, :boolean
  end
end
