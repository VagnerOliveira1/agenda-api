namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Config  de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB...") { %x(rails db:drop) }
      show_spinner("Creating DB...") { %x(rails db:create) }
      show_spinner("Migrating DB...") { %x(rails db:migrate) }
      show_spinner("Creating Admins...") { %x(rails dev:add_admins) }
      show_spinner("Creating Contacts...") { %x(rails dev:add_contact) }
      show_spinner("Creating Addresses...") { %x(rails dev:add_address) }
    else
      puts "You are not in a development environment!"
    end
  end

  desc "Add Admins"
  task add_admins: :environment do
    20.times do |i|
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
        profile: [0,1].sample
      )
    end
  end

  desc "Add Contacts"
  task add_contact: :environment do
    50.times do |i|
      Contact.create!(
        full_name: Faker::Name.name, 
        email: Faker::Internet.email, 
        birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
        cpf: Faker::CPF.number,
        phones_attributes: phones
      )
    end
  end

  desc "Add Addresses"
  task add_address: :environment do
    Contact.all.each do |contact|
      Address.create!(
        zip_code: Faker::Address.zip_code,
        street: Faker::Address.street_name, 
        number: Faker::Address.building_number,
        district: Faker::Address.community,
        city: Faker::Address.city,
        state: Faker::Address.state,
        contact: contact,
      )   
    end
  end

   private

   def phones
    phones = []
     4.times.each do |i|
      phone = {phone_number: Faker::PhoneNumber.phone_number, kind: i}
      phones << phone
     end
    phones
   end

  def show_spinner(msg_start, msg_end = "Finished!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
