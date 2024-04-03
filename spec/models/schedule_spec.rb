require 'rails_helper'

RSpec.describe Schedule, type: :model do
  subject { schedule }

  let(:schedule) { create(:schedule) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:tour) }
  it { is_expected.to validate_presence_of(:available_from) }
  it { is_expected.to validate_numericality_of(:length).only_integer.is_greater_than(0) }
  it { is_expected.to validate_inclusion_of(:day_of_week).in_array(Date::DAYS_INTO_WEEK.values) }
  it { is_expected.to validate_inclusion_of(:day_of_week_index).in_array(described_class::DAY_OF_WEEK_INDEXES) }

  context "when recurring" do
    let(:schedule) { create(:schedule, :recurring) }

    it { is_expected.to validate_presence_of(:day_of_week) }
    it { is_expected.to validate_presence_of(:day_of_week_index) }
  end

  context "when not recurring" do
    it { is_expected.not_to validate_presence_of(:day_of_week) }
    it { is_expected.not_to validate_presence_of(:day_of_week_index) }
  end

  describe '.active_on' do
    subject { described_class.active_on(date) }

    let(:date) { Date.parse('2024-04-05') }

    let!(:active_schedule1) { create(:schedule, available_from: date) }
    let!(:active_schedule2) { create(:schedule, :recurring, available_from: date) }
    let!(:inactive_schedule1) { create(:schedule, available_from: date + 1.day) }
    let!(:inactive_schedule2) { create(:schedule, :recurring, available_from: date + 1.day) }

    it { is_expected.to match_array([active_schedule1, active_schedule2]) }
  end
end
