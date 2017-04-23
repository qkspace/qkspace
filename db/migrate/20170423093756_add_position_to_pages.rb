class AddPositionToPages < ActiveRecord::Migration[5.0]
  def up
    add_column :pages, :position, :integer

    Page.order('id desc').each.with_index do |item, position|
      item.update_attribute :position, position
    end

    change_column :pages, :position, :integer, null: false

    add_index :pages, [:position]
  end

  def down
    remove_column :pages, :position
  end
end
