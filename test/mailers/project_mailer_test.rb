require 'test_helper'

class ProjectMailerTest < ActionMailer::TestCase
  =begin
  test "new_project" do
    mail = ProjectMailer.new_project
    assert_equal "New project", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "project_change" do
    mail = ProjectMailer.project_change
    assert_equal "Project change", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "invite" do
    # Send the email, then test that it got queued
    email = ProjectMailer.new_project(projects(:one))
    assert !ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['me@example.com'], email.from
    assert_equal ['friend@example.com'], email.to
    assert_equal 'You have been invited by me@example.com', email.subject
    assert_equal read_fixture('invite').join, email.body.to_s
  end
  =end
end
