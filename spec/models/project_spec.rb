require 'spec_helper'
require 'ruby-debug'

describe Project do
  let(:project) { FactoryGirl.build(:project) }
  subject { project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start) }
  it { should respond_to(:prevision) }
  it { should respond_to(:user) }

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

  describe "progress of a project" do
    context "when half of the tickets are completed" do
      before do
        Rails.logger.debug project.inspect
        FactoryGirl.create(:ticket, project: project)
        FactoryGirl.create(:ticket, project: project, completed: true)
        Rails.logger.debug project.inspect
      end
      it { project.progress.should be_equal 50 }
    end
    context "when all the tickets are completed" do
      before { project.tickets.each { |t| t.completed = true } }
      it { project.progress.should be_equal 100 }
    end
  end
end


