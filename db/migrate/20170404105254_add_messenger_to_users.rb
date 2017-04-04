class AddMessengerToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :messenger_id, :string
    add_column :users, :profile_pic_url, :string
    add_column :users, :messenger_locale, :string
    add_column :users, :gender, :string
  end
end
