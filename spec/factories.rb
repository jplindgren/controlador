FactoryGirl.define do 
	factory :ticket do
		sequence(:friendly_id) { |n| "{n}" } 
		description "A new ticket"
		completed false
		association :project, factory: :project
	end

	factory :project do
		sequence(:name) { |n| "Test Project#{n}" } 
		prevision Time.new(2014,12,25)
		description "A new test project"
		start Time.now
		association :user, factory: :user
	end

	factory :user do
		sequence(:email) { |n| "joaopozo#{n}@gmail.com" }
		password "12345678"
		name "Joao Paulo"
		admin false
		factory :user_admin do
			admin true
		end
	end
end
