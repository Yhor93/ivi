class AddConstraintsToUsersUsername < ActiveRecord::Migration[8.0]
  def up
    # Asegurarnos de que todos los registros tengan un username
    User.reset_column_information
    User.find_each do |user|
      if user.username.blank?
        user.update_columns(username: "#{user.name.parameterize}#{rand(100..999)}")
      end
    end

    change_column_null :users, :username, false
    add_index :users, :username, unique: true unless index_exists?(:users, :username)
  end

  def down
    change_column_null :users, :username, true
    remove_index :users, :username if index_exists?(:users, :username)
  end
end