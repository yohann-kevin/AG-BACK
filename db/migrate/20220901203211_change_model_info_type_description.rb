class ChangeModelInfoTypeDescription < ActiveRecord::Migration[6.1]
  def change
    change_column :model_infos, :description, :text
  end
end
