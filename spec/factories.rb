FactoryGirl.define do 
	factory :project do
		sequence(:name) { |n| "Test Project#{n}" } 
		prevision Time.new(2014,12,25)
		description "A new test project"
		start Time.now
	end

	factory :profile do
		sequence(:email) { |n| "joaopozo#{n}@gmail.com" }
		name "joao"
	end

	factory :user do
		sequence(:email) { |n| "joaopozo#{n}@gmail.com" }
		password "12345678"
		admin false
		association :profile, factory: :profile
		factory :user_admin do
			admin true
		end
	end
end
