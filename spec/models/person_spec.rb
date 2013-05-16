require 'spec_helper'

describe Person do
  
  it 'is valid' do
  	person = Person.new(first_name: 'Akash', last_name: 'Kh')
  	expect(person).to be_valid
  end

  it 'is invalid without first name' do
  	person = Person.new(first_name: nil)
  	expect(person).to be_invalid
	end

	it 'is invalid without last name' do
		person = Person.new(first_name: 'Akash', last_name: nil)
  	expect(person).to be_invalid
  end

end
