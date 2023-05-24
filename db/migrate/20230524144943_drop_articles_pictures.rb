class DropArticlesPictures < ActiveRecord::Migration[6.1]
  def change
    drop_table :articles_pictures
  end
end

