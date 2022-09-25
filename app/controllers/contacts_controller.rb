class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    contact_data = JSON.parse(request.body.read)
    contact_data["destinator"] = ENV["MAIL_DESTINATOR"]
    @contact = Contact.new(contact_data)

    if @contact.save
      ContactMailer.with(contact_data: @contact).new_contact_mailer.deliver_later
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:destinator, :sender, :object, :content)
    end
end
