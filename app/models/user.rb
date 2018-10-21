class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_many :owned_projects, class_name: "Project", dependent: :destroy
  has_many :project_collaborations, dependent: :destroy
  has_many :collaborated_projects, through: :project_collaborations, source: :project

  def collaborates?(project)
    projects.exists?(project.id)
  end

  def owns?(project)
    owned_projects.exists?(project.id)
  end

  def projects
    Project.editable_by(id)
  end
end
