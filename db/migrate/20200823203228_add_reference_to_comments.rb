class AddReferenceToComments < ActiveRecord::Migration[6.0]
  def change
    change_table :comments do |t|
      t.references :video, null:false, foreign_key: true
    end
  end
end
