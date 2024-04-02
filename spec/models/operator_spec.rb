require 'rails_helper'

RSpec.describe Operator, type: :model do
  subject { create(:operator) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
end
