class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :organization_id
      t.string :organization_name
      t.integer :team_id
      t.string :team_name
      t.integer :user_id

      t.timestamps
    end
  end
end
