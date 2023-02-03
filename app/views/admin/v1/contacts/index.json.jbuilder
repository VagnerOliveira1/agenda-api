json.contacts do
  json.array! @contacts, :id, :full_name, :email
end