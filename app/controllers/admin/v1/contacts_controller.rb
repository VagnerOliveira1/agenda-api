module Admin::V1
  class ContactsController < ApiController
    def index
      @contacts = Contact.all
    end

    def create
      @contact = Contact.new
      @contact.attributes = contact_params
      save_contact!
    end

    def update
      @contact = Contact.find(params[:id])
      @contact.attributes = contact_params
      save_contact!
    end
    
    def destroy
      @contact = Contact.find(params[:id])
      @contact.destroy!
    rescue
      render_error(fields: @contact.errors.messages)
    end
    private 

    def contact_params
      return {} unless params.has_key?(:contact)
      params.require(:contact).permit(:full_name, :email, :cpf, :birth_date, :phones_attributes => [:id, :phone_number, :whatsapp])
    end

    def save_contact!
      @contact.save!
      render :show 
    rescue
      render_error(fields: @contact.errors.messages)
    end
  end
end
