require 'spec_helper'

describe ProjectMailer do
	context "#new_project" do
		let(:user) { FactoryGirl.create(:user, email: "joaopozo@gmail.com", name: "Joao Paulo") }
		let(:project) { Project.create(name: "Test Project", description: "A new test project", start: Time.now, prevision: Time.new(2014,12,25), user: user) }

		subject { ProjectMailer.new_project(project) }

		its(:from) { should include('jpdesenvolver@gmail.com') }
		its(:to) { should include(project.user.email) }
		its(:subject) { should include("Um novo projeto chamado #{project.name} foi criado para voce!") }
	end
end