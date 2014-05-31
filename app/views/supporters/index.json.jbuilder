json.array!(@supporters) do |supporter|
  json.extract! supporter, :id, :name, :email, :phone
  json.url supporter_url(supporter, format: :json)
end
