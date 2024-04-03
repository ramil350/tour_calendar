require 'rails_helper'

describe TourAvailabilityCalendar do
  describe '#call' do
    subject { described_class.new(start_date, end_date).call }

    let(:start_date) { Date.parse('2024-05-01') }
    let(:end_date) { Date.parse('2024-05-10') }

    # every Wednesday from May 1st
    let!(:available_schedule1) { create(:schedule, :recurring, available_from: '2024-05-01', day_of_week: 3, day_of_week_index: 0) }
    # every second Thursday from May 1st
    let!(:available_schedule2) { create(:schedule, :recurring, available_from: '2024-05-01', day_of_week: 4, day_of_week_index: 2) }
    # # every first Sunday from May 1st
    let!(:available_schedule3) { create(:schedule, :recurring, available_from: '2024-05-01', day_of_week: 0, day_of_week_index: 1) }
    # # on May 5th
    let!(:available_schedule4) { create(:schedule, available_from: '2024-05-05') }
    # # on May 9th
    let!(:available_schedule5) { create(:schedule, available_from: '2024-05-01') }

    # # every Wednesday from May 11th
    let!(:unavailable_schedule1) { create(:schedule, :recurring, available_from: '2024-05-11', day_of_week: 3, day_of_week_index: 0) }
    # # every second Thursday until May 1st
    let!(:unavailable_schedule2) { create(:schedule, :recurring, available_from: '2024-04-01', available_until: '2024-05-01', day_of_week: 4, day_of_week_index: 2) }
    # # on May 15th
    let!(:unavailable_schedule3) { create(:schedule, available_from: '2024-05-15') }

    let(:tours_calendar) do
      {
        Date.parse('2024-05-01') => [
          { id: available_schedule1.tour_id, name: available_schedule1.tour.name, length: available_schedule1.length },
          { id: available_schedule5.tour_id, name: available_schedule5.tour.name, length: available_schedule5.length }
        ],
        Date.parse('2024-05-02') => [],
        Date.parse('2024-05-03') => [],
        Date.parse('2024-05-04') => [],
        Date.parse('2024-05-05') => [
          { id: available_schedule3.tour_id, name: available_schedule3.tour.name, length: available_schedule3.length },
          { id: available_schedule4.tour_id, name: available_schedule4.tour.name, length: available_schedule4.length }
        ],
        Date.parse('2024-05-06') => [],
        Date.parse('2024-05-07') => [],
        Date.parse('2024-05-08') => [
          { id: available_schedule1.tour_id, name: available_schedule1.tour.name, length: available_schedule1.length }
        ],
        Date.parse('2024-05-09') => [
          { id: available_schedule2.tour_id, name: available_schedule2.tour.name, length: available_schedule2.length }
        ],
        Date.parse('2024-05-10') => []
      }
    end

    it { is_expected.to match_array(tours_calendar) }
  end
end
