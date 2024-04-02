class Operator < ApplicationRecord
  has_many :tours

  validates :name, presence: true
end
