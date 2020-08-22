class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :like_count
      t.integer :dislike_count
      # When a comment is created
      t.string :videoID
      t.references :comment, null: true, foreign_key: true
      t.timestamps
    end
  end
end
