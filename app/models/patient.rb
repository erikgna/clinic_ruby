class Patient < ApplicationRecord
  belongs_to :user
  
  validates :name, :age, :gender, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :gender, inclusion: { in: %w(Male Female), message: "must be Male or Female" }

end
