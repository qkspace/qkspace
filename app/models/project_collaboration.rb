class ProjectCollaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: :project_id }
  validate  :check_user

  delegate :email, to: :user

  attribute :collaborator_email

  before_validation :set_user, on: :create

  private

  def set_user
    return if user.present?

    self.user = User.find_by(email: collaborator_email)

    errors.add(:collaborator_email, :not_found) unless user
  end

  def check_user
    errors.add(:collaborator_email, :taken) if project.owner == user
  end
end
