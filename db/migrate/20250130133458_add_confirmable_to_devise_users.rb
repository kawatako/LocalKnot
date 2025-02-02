class AddConfirmableToDeviseUsers < ActiveRecord::Migration[7.1] # バージョンは適宜修正
  def change
    add_column :users, :confirmation_token, :string
    add_index :users, :confirmation_token, unique: true
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # (もしメールアドレス変更機能を実装したい場合のみ)
  end
end