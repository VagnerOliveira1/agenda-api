module Admin::V1
  class AddressController < ApiController
    before_action :get_contact
    before_action :set_address, only: [:show, :update, :destroy]
    def index
      @contact = get_contact
      @address = @contact.address
    end

    def create
      @address = @contact.address.new(address_params)
      save_address!
    end

    def update
      @address.update(address_params)
      save_address!
    end
    def show;end 

    def destroy
      @address.destroy!
    rescue
      render_error(fields: @address.errors.messages)
    end
    private 


    def addres_params
      return {} unless params.has_key?(:address)
      params.require(:address).permit(:zip_code, :street, :number, :district, :state, :contact_id)
    end

    def save_address!
      @address.save!
      render :show 
    rescue
      render_error(fields: @address.errors.messages)
    end  

    def set_address
      @address = @contact.address.find(params[:id])
    end
    
    def get_contact
      byebug
      @contact = Contact.find(params[:contact_id])
    end
  end
end
