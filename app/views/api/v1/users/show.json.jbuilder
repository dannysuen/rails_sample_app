if @envelop[:meta][:code] < 300
  json.meta do
    json.(@envelop[:meta], :code)
  end
else
  json.meta do
    json.(@envelop[:meta], :code, :error_type, :error_message)
  end
end

if !@envelop[:data].nil?
  json.data do
    json.(@envelop[:data], :id, :email, :name, :gravatar_url, :created_at, :updated_at)
  end
else
  json.set! :data, nil
end

if !@envelop[:pagination].nil?
  json.pagination do
    json.(@envelop[:pagination], :next_url)
  end
else
  json.set! :pagination, nil
end

