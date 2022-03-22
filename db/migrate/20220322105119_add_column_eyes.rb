class AddColumnEyes < ActiveRecord::Migration[6.1]
  def change
    add_column :model_infos, :eyes, :string
  end
end
