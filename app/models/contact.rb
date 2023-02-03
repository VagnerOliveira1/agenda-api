class Contact < ApplicationRecord
  has_many :address
  has_many :phone
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :cpf, presence: true, uniqueness: true
  validates :birth_date, presence: true
end
