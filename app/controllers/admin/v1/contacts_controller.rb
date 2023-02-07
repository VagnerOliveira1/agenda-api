module Admin::V1
  class ContactsController < ApiController
    before_action :load_contact, only: [:update, :destroy, :show]
    def index
      @contacts = load_contacts
    end

    def create
      @contact = Contact.new
      @contact.attributes = contact_params
      save_contact!
      SendNotificationJob.perform_later(@contact.id)
    end

    def update
      @contact = Contact.find(params[:id])
      @contact.attributes = contact_params
      save_contact!
    end
    def show;end 

    def destroy
      @contact = Contact.find(params[:id])
      @contact.destroy!
    rescue
      render_error(fields: @contact.errors.messages)
    end
    private 

    def load_contact
      @contact = Contact.find(params[:id])
    end

    def load_contacts 
      permitted = params.permit({ search: :full_name}, {order: {}}, :page, :length)
      Admin::ModelLoadingService.new(Contact.all, permitted).call    
    end

    def contact_params
      return {} unless params.has_key?(:contact)
      params.require(:contact).permit(:full_name, :email, :cpf, :birth_date, :phones_attributes => [:id, :phone_number, :kind])
    end

    def save_contact!
      @contact.save!
      render :show 
    rescue
      render_error(fields: @contact.errors.messages)
    end
  end
end
