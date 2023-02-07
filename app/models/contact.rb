class Contact < ApplicationRecord
  searchkick
  
  include NameSearchable
  include Paginatable
  has_many :addresses
  has_many :phones
  accepts_nested_attributes_for :phones, :allow_destroy => true
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :cpf, presence: true, uniqueness: true
  validates :birth_date, presence: true
end
