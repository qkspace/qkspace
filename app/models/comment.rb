class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  def destroy
    update(user: nil, body: nil)
  end

  def deleted?
    user.nil?
  end
end
