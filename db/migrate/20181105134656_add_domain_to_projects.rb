class AddDomainToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :domain, :string
    add_index :projects, :domain, unique: true
  end
end
