class CreateJoinTableLikes < ActiveRecord::Migration[5.1]
  def change
      create_join_table :photos, :users, table_name: :likes do |t|
          t.index [:photo_id, :user_id], unique: true
          t.timestamps
      end
    end
end

# class CreateLikes < ActiveRecord::Migration[5.1]
#   def change
#     create_table :likes do |t|
#       t.integer :photo_id
#       t.integer :user_id
#       t.references :user, foreign_key: true
#       t.references :photo, foreign_key: true
#
#       t.timestamps
#     end
#   end
# end
