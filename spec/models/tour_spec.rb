require 'rails_helper'

RSpec.describe Tour, type: :model do
  subject { create(:tour) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:operator) }
end
