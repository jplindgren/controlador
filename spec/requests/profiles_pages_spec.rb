require 'spec_helper'
require 'ruby-debug'

describe "Profile Page" do
  subject { page }

  describe "#index" do
    context "as regular user should be redirected to #show" do
		  let(:regular_user) { FactoryGirl.create(:user) } 
		  before do
	  	  sign_in(regular_user)
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
        sign_in(admin_user)
        visit profiles_path
      end

      it { should have_title('Profiles')  }
      it { should have_content('Listing profiles') }
      it { current_path.should == profiles_path }
    end
  end #index
end
