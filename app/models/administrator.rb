class Administrator < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def self.find_admin_by_login(login)
    @administrator if find_admin_by_email(login) || find_admin_by_name(login)
  end

  def self.find_admin_by_name(login)
    @administrator = Administrator.find_by(name: login)
    @administrator.nil? ? false : true
  end

  def self.find_admin_by_email(login)
    @administrator = Administrator.find_by(email: login)
    @administrator.nil? ? false : true
  end
end
