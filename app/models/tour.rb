class Tour < ApplicationRecord
  belongs_to :operator
  has_many :schedules

  validates :name, :operator, presence: true
end
