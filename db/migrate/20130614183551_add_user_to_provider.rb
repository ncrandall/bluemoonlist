class AddUserToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :user_id, :integer
    add_column :providers, :company_name, :string
    add_column :providers, :first_name, :string
    add_column :providers, :last_name, :string
    remove_column :providers, :name, :string
    remove_column :providers, :contact, :string
  end
end
