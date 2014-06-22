require 'spec_helper'

describe "Projects" do
  subject { page }

	let(:project) { FactoryGirl.create(:project) }
	let(:user) { FactoryGirl.create(:user) }

	before { sign_in user }
	before(:all) do
		ticket = FactoryGirl.create(:ticket, project: project) 
	end

	describe "detail page" do
		before { visit project_path project }

		#it { should have_title(project.name) }
		it { should have_selector('h3.panel-title', text: project.name) }

		it "should list project's tickets" do
			project.tickets.each do |ticket|
				expect(page).to have_selector("li##{ticket.id}", text: ticket.description)
			end
		end

	end #detail page
end
