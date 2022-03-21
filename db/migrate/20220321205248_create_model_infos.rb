class CreateModelInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :model_infos do |t|
      t.string :model_uuid
      t.integer :size
      t.integer :weight
      t.integer :chest
      t.integer :waist
      t.integer :hips
      t.integer :shoe_size
      t.string :color
      t.string :hair_color
      t.string :astrological
      t.string :description

      t.timestamps
    end
  end
end
