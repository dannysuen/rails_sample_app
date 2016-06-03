json.meta do
  json.(@envelop[:meta], :code)
end


json.data do
  json.(@envelop[:data], :id, :email, :name)
  json.gavatar_url gravatar_url_for @envelop[:data]
  json.(@envelop[:data], :created_at, :updated_at)
end

json.pagination do
  json.(@envelop[:pagination], :next_url)
end
