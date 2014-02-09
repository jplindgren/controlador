require 'spec_helper'

describe Project do
  before do
  	@profile = Profile.new(email: "joaopozo@gmail.com", name: "joao")
   	@project = Project.new(name: "Test Project", description: "A new test project", start: Time.now, prevision: Time.new(2014,12,25), profile: @profile) 
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start) }
  it { should respond_to(:prevision) }
  it { should respond_to(:profile) }

  it { should respond_to(:get_owner) }

  #sanity check
  it {should be_valid}

  describe "when name is not presented" do
  	before { @project.name = " " }
  	it { should_not be_valid }
  end

  describe "when name is bigger than limit" do
  	before { @project.name = "a" * 256 }
  	it { should_not be_valid }
  end

  describe "when the profile is nil" do
  	before { @project.profile = nil }
  	it { should_not be_valid }
  end

  describe "with a project name already taken" do  	
  	it do
  		Project.create!(name: "Test Project", description: "A new test project", start: Time.now, prevision: Time.new(2014,12,25), profile: @profile)
  		@project.should_not be_valid	
  	end
  end

  describe "after created" do
    it "should send a notification" do
    	ProjectMailer.should_receive(:new_project).and_return( double("ProjectMailer", :deliver => true) )
        @project.save
    end
  end

  describe "return value of #get_owner method" do
  	describe "with a profile" do
		specify { expect(@project.get_owner).to eq @profile.name }
  	end

  	describe "without a profile" do
  		before { @profile.name = nil }
  		specify { expect(@project.get_owner).to eq "sem profile?" }
  	end
  end

end


