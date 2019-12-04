class AddYandexMetrikaTrackerIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :yandex_metrika_tracker_id, :string
  end
end
