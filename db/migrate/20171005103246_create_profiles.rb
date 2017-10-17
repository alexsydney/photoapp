class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.text :avatar_data
      t.string :username
      t.references :user, foreign_key: true
      t.text :bio

      t.timestamps

      # only profile per username
      t.index :username, unique: true
    end
  end
end
