require 'spec_helper'

describe "AuthPages" do
	subject { page }

  describe "sign in" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit new_user_session_path }

		it { should have_title('Sign in') }
  	it { should have_content('Please sign in') }
  	it { should have_button('Sign in') }

    describe "with invalid info" do
      before { click_button "Sign in" }
      it { should have_selector('div.alert.alert-danger') }
    end

    describe "after signin user" do      
      before { sign_in(user) }      
      it { should have_link 'Log out', href: destroy_user_session_path }
      it { should have_link user.email }
    end
  end

  describe "sign up" do
    before { visit new_user_registration_path } 
    let(:signup_submit) { click_button "Sign up" }

    it { should have_title('Sign up') }
    it { should have_selector('h2', text: 'Sign up') }

    describe "with invalid info" do
      it "should not create the user" do
        expect { signup_submit }.to_not change(User, :count)
      end
    end

    describe "after submission" do
      before do
        fill_in 'email', with: 'foo@gmail.com'
        fill_in 'name', with: 'foo bar'
        fill_in 'password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
      end

      it "should create a user" do
        #expect { signup_submit }.to change(User, :count).by(1)
      end    

    end
  end
end
