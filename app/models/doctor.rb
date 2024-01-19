class Doctor < ApplicationRecord
  belongs_to :user

  validates :name, :specialization, :experience_years, presence: true
  validates :experience_years, numericality: { only_integer: true, greater_than: 0 }
  validates :specialization, inclusion: { in: %w(Generalist Specialist), message: "must be Generalist or Specialist" }

  def self.search(search)
    if search
      where(["name LIKE ?","%#{search}%"])
    else
      all
    end
  end
end
