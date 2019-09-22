class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :page
  belongs_to :parent, optional: true, class_name: "Comment"

  ltree :path

  def set_path(project_id)
    if parent_id.nil?
      update!(path: "Project_#{project_id}.Page_#{page_id}.Comment_#{id}")
    else
      parent_path = page.comments.find_by(id: parent_id).path
      update!(path: parent_path + ".Comment_#{id}")
    end
  end

  def soft_delete!
    update!(deleted: true)
  end
end
