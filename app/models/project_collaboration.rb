class ProjectCollaboration < ApplicationRecord
  belongs_to :user, inverse_of: :project_collaborations
  belongs_to :project, inverse_of: :collaborations

  validates :user_id, uniqueness: { scope: :project_id }
  validate  :disallow_owner

  delegate :email, to: :user

  attribute :collaborator_email
  validates :collaborator_email, format: /\A.+@.+\z/

  after_initialize :set_user
  after_validation :move_uniqueness_error

  def set_user
    return if user.present?

    self.user = User.find_or_create_by(email: collaborator_email)
  end

  private

  def disallow_owner
    errors.add(:collaborator_email, :taken) if project.owner == user
  end

  def move_uniqueness_error
    errors[:user_id].each do |error|
      errors.add(:collaborator_email, error)
    end
  end
end
