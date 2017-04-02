class AddSlugToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :slug, :string
  end
end
