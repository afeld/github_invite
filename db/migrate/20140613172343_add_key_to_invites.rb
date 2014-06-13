class AddKeyToInvites < ActiveRecord::Migration
  def change
    change_table :invites do |t|
      t.string :key
      t.index :key
    end
  end
end
