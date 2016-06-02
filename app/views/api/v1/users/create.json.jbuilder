json.meta do
  json.(@envelop[:meta], :code)
end

json.data do
  json.(@envelop[:data], :id, :email, :name, :created_at, :updated_at)
end

json.pagination do
  json.(@envelop[:pagination], :next_url)
end

