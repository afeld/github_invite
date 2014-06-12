class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :github_id
      t.string :github_username

      t.timestamps
    end
  end
end
