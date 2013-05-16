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

end
