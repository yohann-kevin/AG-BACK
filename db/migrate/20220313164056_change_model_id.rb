class ChangeModelId < ActiveRecord::Migration[6.1]
  def change
    change_column :models, :id, :string, limit: 36, primary: true
  end
end
