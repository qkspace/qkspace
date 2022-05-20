class MistakeReportForm < BaseForm
  attribute :page
  attribute :text
  attribute :correction

  validates :page, :text, :correction, presence: true
end
