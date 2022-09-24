class ContactMailer < ApplicationMailer
  def new_contact_mailer
    @contact_data = params[:contact_data]
    @url  = 'http://www.gmail.com'
    mail(to: 'agscouting.app@gmail.com', subject: @contact_data[:object])
  end
end
