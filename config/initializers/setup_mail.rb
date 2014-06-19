ActionMailer::Base.default_url_options[:host] = "localhost:3000" unless Rails.env.production?

if Rails.env != 'test'
	emails_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
	ActionMailer::Base.smtp_settings = emails_settings[Rails.env] unless emails_settings[Rails.env].nil?
end