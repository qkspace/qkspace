class User < ApplicationRecord
  before_validation :downcase_email

  has_many :owned_projects, class_name: "Project", dependent: :destroy
  has_many :project_collaborations, dependent: :destroy
  has_many :collaborated_projects, through: :project_collaborations, source: :project
  has_many :sessions, inverse_of: :user

  validates :email,
    format: /\A.+@.+\z/,
    uniqueness: true

  def collaborates?(project)
    projects.exists?(project.id)
  end

  def owns?(project)
    owned_projects.exists?(project.id)
  end

  def projects
    Project.editable_by(id)
  end

  private

  def downcase_email
    self.email &&= self.email.downcase
  end
end
