class ProjectMailer < ActionMailer::Base
  default from: "jpdesenvolver@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #
  def new_project(project)
    @greeting = "Ola"
    @project = project
    @user = @project.user

    mail to: @user.email, subject: "Um novo projeto chamado #{project.name} foi criado para voce!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.project_change.subject
  #
  def project_change
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
