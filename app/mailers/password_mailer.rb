class PasswordMailer < ApplicationMailer
  default "Message-ID" => "<#{SecureRandom.uuid}@gmail.com>"

  def new_password_mailer
    @renew_password = params[:renew_password]
    @secure_url = "#{ENV['AG_FRONT']}/renew/password/#{@renew_password[:secure_id]}"
    @url = "http://www.gmail.com"
    mail(to: @renew_password[:agent_email], subject: "password renew")
  end
end
