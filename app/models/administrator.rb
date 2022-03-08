class Administrator < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def self.find_admin_by_login(login)
    if find_admin_by_email(login) || find_admin_by_name(login)
      return @administrator
    else
      return nil
    end
  end

  private

  def self.find_admin_by_name(login)
    @administrator = Administrator.find_by(name: login)
    return @administrator.nil? ? false : true
  end

  def self.find_admin_by_email(login)
    @administrator = Administrator.find_by(email: login)
    return @administrator.nil? ? false : true
  end
end
