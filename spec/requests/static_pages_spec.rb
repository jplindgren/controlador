require 'spec_helper'
require 'ruby-debug'

describe "Static pages" do
  subject { page }

  describe "GET /home" do
  	before { visit root_path }

    it { should have_title('Home') }

    it { should have_link('Sign Up') }
    it { should have_link('Log in') }


    describe "for signed users" do
    	let!(:user) { FactoryGirl.create(:user) }
        let!(:projects) { FactoryGirl.create_list(:project, 3 ,{ user: user }) }
    	before { sign_in user }

        it { should have_link('Projetos', href: projects_path) }
        it { should have_link(user.email, href: edit_user_registration_path) }
        it { should have_link('Log out', href: destroy_user_session_path) }

        it { should_not have_link('Sign Up') }
        it { should_not have_link('Log in') } 

        it { should have_selector('h3.panel-title', text: 'Painel de controle') }        

        it "should list users project" do
            user.projects.each do |project|
                expect(page).to have_selector('li', text: project.name) 
            end
        end
    end

    describe "for non_signed users" do
    	it { should have_css('div#myCarousel>div.carousel-inner>div.item>img') }
        it { should have_content('Example headline.') }
        it { should have_content('Another example headline.') }
        it { should have_content('One more for good measure.') }
        
        it { should have_link('Sign up today', href: new_user_registration_path) }
        it { should have_css('a.btn-primary[role="button"]', text: 'Browse gallery') }
        it { should have_css('a.btn-primary[role="button"]', text: 'Learn more') }

        it { should have_selector('h2', text: 'Projetos') }
        it { should have_selector('h2', text: 'Tickets') }
        it { should have_selector('h2', text: 'Contato') }

        it { should have_selector('h2', text: 'First featurette heading.') }
        it { should have_selector('h2', text: "Oh yeah, it's that good.") }
    end
  end

end
