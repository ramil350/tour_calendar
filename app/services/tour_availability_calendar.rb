# TourAvailabilityCalendar builds a calendar for the givn date interval
# and lists all the available tours adn their legnths for each day

class TourAvailabilityCalendar
  def initialize(start_date, end_date)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
    @tours = {}
  end

  def call
    (@start_date..@end_date).each do |date|
      day_of_week = date.wday
      day_of_week_index = date.day.fdiv(7).ceil

      schedules = non_recurring_schedules(date).includes(:tour).
        or(recurring_schedules(date, day_of_week, day_of_week_index))

      add_availabile_tours(date, schedules)
    end

    return @tours
  end

  private

  def non_recurring_schedules(date)
    Schedule.where(recurring: false).where(available_from: date)
  end

  def recurring_schedules(date, day_of_week, day_of_week_index)
    Schedule.where(recurring: true).active_on(date).
      where(day_of_week: day_of_week).
      where("day_of_week_index = ? OR day_of_week_index = ?", day_of_week_index, Schedule::DAY_OF_WEEK_INDEX_ALL)
  end

  def add_availabile_tours(date, schedules)
    @tours[date] ||= []

    schedules.find_each do |schedule|
      @tours[date] += [{
        id: schedule.tour_id,
        name: schedule.tour.name,
        length: schedule.length
      }]
    end
  end
end
