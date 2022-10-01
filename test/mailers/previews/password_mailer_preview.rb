# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview
  def new_password_mailer
    @renew_password = {
      "agent_email": "toto@gmail.com",
      "secure_id": "19232a05-f65e-426e-b76a-03ad80e29ddc",
  }

  PasswordMailer.with(renew_password: @renew_password).new_password_mailer
  end
end
