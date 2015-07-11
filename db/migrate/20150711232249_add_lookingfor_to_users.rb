class AddLookingforToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lookingfor, :string
  end
end
