class ThreadedItem < ApplicationRecord
  include MarkdownFieldConcern

  attribute :parent_id, :integer

  belongs_to :user, optional: true
  belongs_to :page

  ltree :path, options: {cascade: false}

  validates :source, presence: true

  validate :validate_parent_id, if: -> { parent_id.present? }

  def soft_delete!
    update!(deleted: true)
  end

  # should be called in a controller, because we don't know ID on model creation
  def set_path!
    project_id = page.project_id
    class_name = self.class.name.underscore

    if parent_id.nil?
      update!(path: "#{class_name}_#{id}")
    else
      update!(path: self.class.find_by(id: parent_id).path + ".#{class_name}_#{id}")
    end
  end

  def validate_parent_id
    parent = self.class.find_by(id: parent_id, page: page)

    if !parent
      errors.add(:parent_id, :invalid)
    end
  end
end
