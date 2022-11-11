# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview
  def new_password_mailer
    @renew_password = {
      "agent_email": "toto@gmail.com",
      "secure_id": "7069feeb-600e-4b50-bc13-6b945d3d7cf3",
  }

  PasswordMailer.with(renew_password: @renew_password).new_password_mailer
  end
end
