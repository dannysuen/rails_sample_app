if @envelop[:meta][:code] < 300
  json.meta do
    json.(@envelop[:meta], :code)
  end
else
  json.meta do
    json.(@envelop[:meta], :code, :error_type, :error_message)
  end
end

json.data @microposts

json.pagination do
  json.(@envelop[:pagination], :next_url)
end
