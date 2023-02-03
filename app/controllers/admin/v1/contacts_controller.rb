module Admin::V1
  class ContactsController < ApiController
    def index
      @contacts = Contact.all
    end
  end
end
