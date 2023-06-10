class DropTableArticlesPictures < ActiveRecord::Migration[6.1]
  def change
    drop_table(:articles_pictures, if_exists: true)
  end
end
