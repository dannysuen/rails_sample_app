json.meta do
  json.(@envelop[:meta], :code)
end


json.data @users, :id, :name, :email, :gravatar_url

json.pagination do
  json.(@envelop[:pagination], :next_url)
end
