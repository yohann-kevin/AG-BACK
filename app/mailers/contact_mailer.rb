class ContactMailer < ApplicationMailer
  default "Message-ID" => "<#{SecureRandom.uuid}@gmail.com>"

  def new_contact_mailer
    @contact_data = params[:contact_data]
    @url = "http://www.gmail.com"
    mail(to: @contact_data[:destinator], subject: @contact_data[:object])
  end
end
