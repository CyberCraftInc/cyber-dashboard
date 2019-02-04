class Event < ApplicationRecord
  has_many :targets, dependent: :destroy
  belongs_to :user
  enum status: %i[scheduled done]
  validates :description, :user, :finish_date, presence: true
  accepts_nested_attributes_for :targets, allow_destroy: true
  scope :sort_reverse_by_finish_date, -> { order(finish_date: :desc) }

  def self.event_statistic(events)
    statuses = {}
    events.each do |event|
      if statuses.key?(event.status)
        statuses[event.status] += 1
      else
        statuses[event.status] = 1
      end
    end
    statuses
  end

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
end
