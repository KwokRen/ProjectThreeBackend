class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      # Creating a separate table for likes allow us to keep track of whether
      # a user has liked a video or not. It also provides us with the number
      # of likes/dislikes that a video has obtained
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.boolean :is_liked
      t.timestamps
    end
  end
end
