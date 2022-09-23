class Agent < ApplicationRecord
  validates_uniqueness_of :email

  def self.find_agent_by_email(email)
    Agent.select(:id, :firstname, :lastname, :email, :password).find_by(email: email)
  end
end
