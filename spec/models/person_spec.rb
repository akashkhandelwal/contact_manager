require 'spec_helper'

describe Person do

	let(:person) do
		Person.new(first_name: "Akash", last_name: "Kh")
	end
  
  it 'is valid' do
  	expect(person).to be_valid
  end

  it 'is invalid without first name' do
  	person.first_name = nil
  	expect(person).to be_invalid
	end

	it 'is invalid without last name' do
		person.last_name = nil
  	expect(person).to be_invalid
  end

  it 'responds with its created phone numbers' do
    person.phone_numbers.build(number: '555-8888')
    expect(person.phone_numbers.map(&:number)).to eq(['555-8888'])
  end

  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'akash@jombay.com')
    expect(person.email_addresses.map(&:address)).to eq(['akash@jombay.com'])
  end

  it "convert to a string with last name, first name" do
    expect(person.to_s).to eq "Kh, Akash"
  end
end
