class ChangeAgentEmailToUnique < ActiveRecord::Migration[6.1]
  def change
    change_column :agents, :email, :string, unique: true
  end
end
