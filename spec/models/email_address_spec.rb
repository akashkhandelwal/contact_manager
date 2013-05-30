require 'spec_helper'

describe EmailAddress do
  
  let(:email_address) { EmailAddress.new(address: 'info@company.com', contact_id: 1, contact_type: 'Person') }

  it 'is valid' do
  	expect(email_address).to be_valid
  end

  it 'is invalid whithout address' do
  	email_address.address = nil
  	expect(email_address).to be_invalid
  end

  it 'must have a reference to a person' do
  	email_address.contact_id = nil
  	expect(email_address).to be_invalid
  end

  it 'must be linked to a contact' do
    email_address.contact_id = nil
  	expect(email_address).to_not be_valid
  end

  it 'is associated with a person' do
    expect(email_address).to respond_to(:contact)
  end
end
