require 'spec_helper'
require 'ruby-debug'

describe "Profile Page" do
  subject { page }

  describe "#index" do
    context "as regular user should be redirected to #show" do
		  let(:regular_user) { FactoryGirl.create(:user) } 
		  before do
	  	  signin(regular_user)
		    visit profiles_path
		  end

			it { should have_title('Profile')  }
		  it { should have_content(regular_user.profile.name) }
		  it { should have_content(regular_user.email) }      
		  it { should have_link 'Novo Projeto', href: new_profile_project_path(regular_user.profile) }
      it { current_path.should == profile_path(regular_user.profile) }

    end #as regular user

    context "as admin user" do 
      let(:admin_user) { FactoryGirl.create(:user_admin) } 
      before do
        signin(admin_user)
        visit profiles_path
      end

      it { should have_title('Profiles')  }
      it { should have_content('Listing profiles') }
      it { current_path.should == profile_path(regular_user.profile) }
    end
  end #index

  def signin(user)
  	visit new_user_session_path
  	fill_in "user_email", with: user.email
  	fill_in "user_password", with: user.password
  	click_button "Sign in"
  end
end
