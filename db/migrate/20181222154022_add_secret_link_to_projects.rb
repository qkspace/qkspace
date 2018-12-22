class AddSecretLinkToProjects < ActiveRecord::Migration[5.2]
  def change
    change_table :projects do |t|
      t.boolean :secret_enabled, default: false, null: false
      t.string :secret_token
    end
  end
end
