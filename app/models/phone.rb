class Phone < ApplicationRecord
  belongs_to :contact
  validates :phone_number, presence: true
  validates_inclusion_of :whatsapp, in: [true, false]
end
