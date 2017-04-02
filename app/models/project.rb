class Project < ApplicationRecord
  has_many :pages, dependent: :destroy

  before_create :generate_first_page

  def generate_first_page
    pages.build(title: title)
  end
end
