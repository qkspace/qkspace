class ProjectCollaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: :project_id }

  delegate :email, to: :user

  attribute :collaborator_email

  before_validation :set_user, on: :create

  private

  def set_user
    self.user = User.find_by(email: collaborator_email)

    errors.add(:collaborator_email, :not_found) unless user
  end
end
