class Agent < ApplicationRecord
  validates :email, uniqueness: true

  def self.find_agent_by_email(email)
    Agent.select(:id, :firstname, :lastname, :email, :password).find_by(email: email)
  end
end
