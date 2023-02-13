class Contact < ApplicationRecord
  searchkick
  include NameSearchable
  include Paginatable
  has_many :addresses, dependent: :destroy
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :cpf, presence: true, uniqueness: true
  validates :birth_date, presence: true
end
