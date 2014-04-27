require 'spec_helper'
require 'ruby-debug'

describe Project do
  let(:profile) { FactoryGirl.build(:profile) }
  let(:project) { FactoryGirl.build(:project, profile: profile) }
  subject { project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start) }
  it { should respond_to(:prevision) }
  it { should respond_to(:profile) }
  it { should respond_to(:user) }

  it { should respond_to(:get_owner) }

  #sanity check
  it {should be_valid}

  describe "when name is not presented" do
  	before { project.name = " " }
  	it { should_not be_valid }
  end

  describe "when a user is not presented" do
    before { project.user = nil }
    it { should_not be_valid }
  end

  describe "when name is bigger than limit" do
  	before { project.name = "a" * 256 }
  	it { should_not be_valid }
  end

  describe "when the profile is nil" do
  	before { project.profile = nil }
  	it { should_not be_valid }
  end

  describe "with a project name already taken" do  	
    let(:project_with_same_name) { project.dup }
    
    before do
      project.save
      project_with_same_name.save
    end
  	it { project_with_same_name.should_not be_valid }
  end

  describe "after created" do
    it "should send a notification" do
    	ProjectMailer.should_receive(:new_project).and_return( double("ProjectMailer", :deliver => true) )
      project.save
    end
  end

  describe "return value of #get_owner method" do
  	context "with a profile" do
		specify { expect(project.get_owner).to eq project.profile.name }
  	end

  	context "without a profile" do
  		before { project.profile = nil }
  		specify { expect(project.get_owner).to eq 'sem profile!' }
  	end
  end
end


