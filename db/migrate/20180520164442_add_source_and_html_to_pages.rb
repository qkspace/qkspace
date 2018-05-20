class AddSourceAndHtmlToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :source, :text
    add_column :pages, :html, :text
  end
end
