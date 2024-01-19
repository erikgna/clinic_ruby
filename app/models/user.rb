class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :patients, dependent: :destroy
  has_many :doctors, dependent: :destroy

  before_validation :set_default_admin

  private

  def set_default_admin
    self.admin = false if admin.nil?
  end
end
