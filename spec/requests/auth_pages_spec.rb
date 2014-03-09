require 'spec_helper'

describe "AuthPages" do
	subject { page }

  describe "GET /new_user_session" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit new_user_session_path }

		it { should have_title('Sign in') }
  	it { should have_content('Please sign in') }
  	it { should have_button('Sign in') }

    describe "after signin user" do      
    	before { signin(user) }			
			it { should have_link 'Log out', href: destroy_user_session_path }
			it { should have_link user.email }
    end
  end

  def signin(user)
  	fill_in "user_email", with: user.email
  	fill_in "user_password", with: user.password
  	click_button "Sign in"
  end
end
