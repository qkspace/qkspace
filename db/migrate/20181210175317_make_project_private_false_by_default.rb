class MakeProjectPrivateFalseByDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :private, :boolean, default: false
  end
end
