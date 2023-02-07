class Phone < ApplicationRecord
  belongs_to :contact
  validates :phone_number, presence: true
  enum kind: { home: 0, office: 1, mobile: 2, whatsapp: 3}
end
