module Admin::V1
  class ContactsController < ApiController
    def index
      @contacts = Contact.all
    end

    def create
      @contact = Contact.new
      @contact.attributes = contact_params
      @contact.save!
      render :show
    rescue 
      render json: { errors: { fields: @contact.errors.messages }}, status: :unprocessable_entity
    end

    private 

    def contact_params
      return {} unless params.has_key?(:contact)
      params.require(:contact).permit(:full_name, :email, :cpf, :birth_date)
    end
  end
end
