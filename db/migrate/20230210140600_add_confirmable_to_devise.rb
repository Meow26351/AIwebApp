class AddConfirmableToDevise < ActiveRecord::Migration[7.0]
  def up
    add_column :agents, :confirmation_token, :string
    add_column :agents, :confirmed_at, :datetime
    add_column :agents, :confirmation_sent_at, :datetime
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :agents, :confirmation_token, unique: true
    # User.reset  _column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Agent.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_index :agents, :confirmation_token
    remove_columns :agents, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :users, :unconfirmed_email # Only if using reconfirmable
  end
end
