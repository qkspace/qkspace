class AddDraftToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :draft, :boolean, default: false
  end
end
