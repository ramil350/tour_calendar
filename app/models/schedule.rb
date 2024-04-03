# Schedule model configures tour availability which could be an exact date
# as well as recurring availability every day of the week
# or every Nth day of the week of the month
#
# Attributes
#   tour_id: reference to tour
#   length: tour length in days
#   day_of_week: day of the week number (Sun, Mon, Tue, ...) = (0..6)
#   day_of_week_index: N from every Nth day of the week of the month.
#   recurring: flag indicating if it is an exact date or a recurring availability
#   available_from: date when tour would become available (for recurring tours) or start date (for non-recurring tours)
#   available_until: date after which tour is no longer available (applies to recurring tours only)

class Schedule < ApplicationRecord
  DAY_OF_WEEK_INDEXES =[
    DAY_OF_WEEK_INDEX_ALL = 0,
    DAY_OF_WEEK_INDEX_EVERY_FIRST = 1,
    DAY_OF_WEEK_INDEX_EVERY_SECOND = 2,
    DAY_OF_WEEK_INDEX_EVERY_THIRD = 3,
    DAY_OF_WEEK_INDEX_EVERY_FOURTH = 4
  ].freeze

  belongs_to :tour

  validates :tour, :available_from, presence: true
  validates :length, numericality: { greater_than: 0, only_integer: true }
  validates :day_of_week, inclusion: Date::DAYS_INTO_WEEK.values, allow_nil: true
  validates :day_of_week_index, inclusion: DAY_OF_WEEK_INDEXES, allow_nil: true
  validates :day_of_week, :day_of_week_index, presence: true, if: :recurring?
  validates :recurring, inclusion: [true, false]

  def self.active_on(date)
    where("available_from <= ?", date).
      where("available_until IS NULL OR available_until >= ?", date)
  end
end
