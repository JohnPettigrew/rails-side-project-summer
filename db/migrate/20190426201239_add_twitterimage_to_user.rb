class AddTwitterimageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_user_url, :string
  end
end
