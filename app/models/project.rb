class Project < ApplicationRecord
  has_many :pages, dependent: :destroy
end
