require 'spec_helper'

describe User do
	
	let(:user) { Fabricate(:user) }
  
  it 'has associated people' do
  	expect(user.people).to be_instance_of(Array)
  end

  it 'builds associate people' do
  	person1 = Fabricate :person
  	person2 = Fabricate :person
  	[person1, person2].each do |person|
  		expect(user.people).not_to include person
  		user.people << person
  		expect(user.people).to include person
  	end
  end

  it 'builds associate companies' do
  	company1 = Fabricate :company
  	company2 = Fabricate :company
  	[company1, company2].each do |company|
  		expect(user.companies).not_to include company
  		user.companies << company
  		expect(user.companies).to include company
  	end
  end
end

