class FixProjectsWithNoPages < ActiveRecord::Migration[5.0]
  def up
    Project.left_joins(:pages).where(pages: { id: nil }).each do |project|
      project.generate_first_page
      project.save!
    end
  end

  def down; end
end
