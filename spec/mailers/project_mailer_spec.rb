require 'spec_helper'

describe ProjectMailer do
	context "#new_project" do
		let(:profile) { Profile.create(email: "joaopozo@gmail.com", name: "joao") }
		let(:project) { Project.create(name: "Test Project", description: "A new test project", start: Time.now, prevision: Time.new(2014,12,25), profile: profile) }

		#I need to stub every property used in the enail process? The tests complained about not giving the url_to_follow method. Wtf?
		#let(:profile) { stub(email: "joaopozo@gmail.com", name: "joao") }
		#let(:project) { stub(name: "Test Project", description: "A new test project", start: Time.now, prevision: Time.new(2014,12,25), profile: profile) }

		subject { ProjectMailer.new_project(project) }

		its(:from) { should include('jpdesenvolver@gmail.com') }
		its(:to) { should include(project.profile.email) }
		its(:subject) { should include("Um novo projeto chamado #{project.name} foi criado para voce!") }
	end
end