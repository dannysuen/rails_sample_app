json.meta do
  json.(@envelop[:meta], :code)
end

json.data do
  json.(@user, :id, :email, :name, :gravatar_url)
  json.token @user.authentication_token
end

json.pagination do
  json.(@envelop[:pagination], :next_url)
end
