FactoryGirl.define do 
	factory :provider do
		name	"Joe the Plumber"
		contact "Joe Shmoe"
		phone		"555-555-5555"
		street	"123 Fake St"
		city		"Springfield"
		state		"OR"
		zip			"97475"
	end

	factory :user do
		sequence(:email) { |n| "example_#{n}@example.com" }
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
		name "Plumber"
	end

	factory :twilio_job do
		name "John Doe"
		phone "555-555-5555"
	end

	factory :twilio_contact do
		name "Joe Plumber"
		phone "555-555-5555"
		call_order 0
	end
end