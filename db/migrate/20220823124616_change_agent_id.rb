class ChangeAgentId < ActiveRecord::Migration[6.1]
  def change
    change_column :agents, :id, :string, limit: 36, primary: true
  end
end
