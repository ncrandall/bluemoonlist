FactoryGirl.define do 

	factory :request_provider do
		sequence(:call_order) { |n| n }
		contacted false
		accepted false
	end

	factory :provider do
		company_name	"Joe the Plumber"
		first_name "Joe" 
		last_name "Shmoe"
		phone		"555-555-5555"
		street	"123 Fake St"
		city		"Springfield"
		state		"OR"
		zip			"97475"
	end

	factory :user do
		sequence(:email) { |n| "example_#{n}@example.com" }
		first_name "John"
		last_name "Doe"
		password "foobar"
		password_confirmation "foobar"
		phone "555-555-5555"
		street "123 Fake St"
		city "Springfield"
		state "OR"
		zip "97475"
	end

	factory :request do
		description "Plumber"
		phone '555-555-5555'
		status :active
	end

	factory :category do
		sequence(:name) { |n| "Plumber#{n}" }
	end

	factory :twilio_job do
		name "John Doe"
		phone "555-555-5555"
		contact_method 0
	end

	factory :twilio_contact do
		name "Joe Plumber"
		phone "555-555-5555"
		category "Plumber"
		call_order 0
	end
end