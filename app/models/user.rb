class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :projects, dependent: :destroy

  def owns?(project)
    projects.exists?(project.id)
  end
end
