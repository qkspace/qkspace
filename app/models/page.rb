class Page < ApplicationRecord
  belongs_to :project
  has_many :blocks
end
