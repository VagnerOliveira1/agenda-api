class Address < ApplicationRecord
  belongs_to :contact
  validates :zip_code, presence: true
  validates :street, presence: true
  validates :number, presence: true
  validates :district, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
