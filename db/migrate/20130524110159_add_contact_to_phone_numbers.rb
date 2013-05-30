class AddContactToPhoneNumbers < ActiveRecord::Migration
  def change
  	add_column :phone_numbers, :contact_id, :integer
  	add_column :phone_numbers, :contact_type, :string
  end
end
