class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :page
  belongs_to :parent, optional: true, class_name: "Comment"

  def comments
    Comment.where(parent_id: id)
  end

  def soft_delete!
    self.deleted = true
    save!
  end
end
