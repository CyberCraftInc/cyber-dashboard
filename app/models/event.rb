class Event < ApplicationRecord
  has_many :targets, dependent: :destroy
  belongs_to :user

  validates :description, :user, :start_date, :finish_date, presence: true
  validate :date_validation

  enum status: %i[scheduled done canceled]
  accepts_nested_attributes_for :targets, allow_destroy: true
  scope :sort_reverse_by_finish_date, -> { order(finish_date: :desc) }

  def data
    {
      id: id,
      description: description,
      start_date: start_date,
      finish_date: finish_date,
      comments: comments,
      summary: summary,
      targets: targets.map(&:data),
      status: status
    }
  end

  private

  def date_validation
    return unless finish_date.present? && start_date.present?

    errors.add(:finish_date, :bad_finish_date) if finish_date < start_date
  end
end
