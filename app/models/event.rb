class Event < ApplicationRecord
  has_many :targets, dependent: :destroy
  belongs_to :user

  validates :description, :user, :start_date, :finish_date, presence: true
  validate :date_validation

  enum status: { scheduled: 0, done: 1, canceled: 2 }
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

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.start_date.strftime("%Y%m%dT%H%M%S")
    event.dtend = self.finish_date.strftime("%Y%m%dT%H%M%S")
    event.summary = self.description
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.comment = self.comments
    event
  end

  private

  def date_validation
    return unless finish_date.present? && start_date.present?

    errors.add(:finish_date, :bad_finish_date) if finish_date < start_date
  end
end
