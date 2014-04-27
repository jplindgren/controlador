require 'spec_helper'
require 'ruby-debug'

describe StaticPagesController do
	describe "GET /home" do

		before { get 'home' }

		it "should have render the right template view" do
    	response.should render_template('home')
    end

    describe "for signed users" do
    	login_user

    	#it { expect(response).to render_template(:partial => 'shared/_home_logged')	}
    end

    describe "for non_signed users" do
    	#it { expect(response).to render_template(:partial => 'shared/_home_not_logged') }
    end
	end
end