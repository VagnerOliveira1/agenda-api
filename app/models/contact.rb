class Contact < ApplicationRecord
    validates :full_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :cpf, presence: true, uniqueness: true
    validates :birth_date, presence: true
end
