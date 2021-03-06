json.meta do
  json.(@envelop[:meta], :code)
end

json.data do
  json.(@envelop[:data], :id, :email, :name, :gravatar_url, :created_at, :updated_at)
end

if !@envelop[:pagination].nil?
  json.pagination do
    json.(@envelop[:pagination], :next_url)
  end
else
  json.set! :pagination, nil
end