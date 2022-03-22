class AddColumnSexe < ActiveRecord::Migration[6.1]
  def change
    add_column :models, :sexe, :string
  end
end
