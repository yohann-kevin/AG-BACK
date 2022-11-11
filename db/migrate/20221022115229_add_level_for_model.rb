class AddLevelForModel < ActiveRecord::Migration[6.1]
  def change
    add_column :models, :level, :string, default: 'T7'
  end
end
