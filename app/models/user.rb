class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_many :projects, dependent: :destroy
  has_many :project_collaborations, dependent: :destroy

  def owns?(project)
    projects.exists?(project.id)
  end
end
