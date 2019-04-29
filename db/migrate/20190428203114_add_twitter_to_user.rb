class AddTwitterToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_key, :string
    add_column :users, :twitter_secret, :string
  end
end
