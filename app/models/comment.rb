class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :page
  belongs_to :parent, optional: true, class_name: "Comment"

  ltree :path

  validates :body, presence: true, allow_blank: false

  def soft_delete!
    update!(deleted: true)
  end

  def set_path(project_id)
    if parent_id.nil?
      update!(path: "Project_#{project_id}.Page_#{page_id}.Comment_#{id}")
    else
      update!(path: page.comments.find_by(id: parent_id).path + ".Comment_#{id}")
    end
  end
end
