class CreateJoinTableFollowers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :followed, :follower, table_name: :followers, column_options: {foreign_key: {to_table: :users }} do |t|
      t.index [:followed_id, :follower_id], unique: true
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end

# class CreateFollowers < ActiveRecord::Migration[5.1]
#   def change
#     create_table :followers do |t|
#       t.integer :follower_id
#       t.integer :following_id
#       t.references :user, foreign_key: true
#
#       t.timestamps
#     end
#   end
# end
