require 'spec_helper'

describe EmailAddress do
  
  let(:email_address) { EmailAddress.new(address: 'akash@company.com') }

  it 'is valid' do
  	expect(email_address).to be_valid
  end

  it 'is invalid whithout address' do
  	email_address.address = nil
  	expect(email_address).to be_invalid
  end
end
