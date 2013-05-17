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
		email "example@example.com"
		password "foobar"
		password_confirmation "foobar"
		phone "555-555-5555"
		street "123 Fake St"
		city "Springfield"
		state "OR"
		zip "97475"
	end

	factory :category do
		name "Plumber"
	end
end