class AddTokenRevokedAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :token_revoked_at, :datetime
  end
end
