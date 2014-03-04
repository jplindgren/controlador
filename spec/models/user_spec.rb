require 'spec_helper'

describe User do 
	let(:user) { @user = FactoryGirl.build(:user) }
	subject { user }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:admin) }
	it { should respond_to(:profile) }

	#sanity check
	it { should be_valid }

	describe "when password is blank" do
		before { user.password = '' }
		it { should_not be_valid }
	end

	describe "when password has not enough length" do
		before { user.password = '1' * 7 }
		it { should_not be_valid }
	end

	describe "when administrator" do
		before { user.admin = true }
		it { should be_is_admin }
	end

	describe "#list_valid_projects" do
		let(:admin) { FactoryGirl.build(:user_admin) }
    before do
        user.profile.projects.new(FactoryGirl.attributes_for(:project)) 
        admin.profile.projects.new(FactoryGirl.attributes_for(:project))
        user.save
        admin.save
    end

    describe "when user is admin" do      
      it "should return all projects" do
        expect(admin.list_valid_projects).to have(2).items
      end
    end

    describe "when user is not admin" do
      it "should return just owned by the user" do
        expect(user.list_valid_projects).to have(1).items
      end
    end    
  end
end