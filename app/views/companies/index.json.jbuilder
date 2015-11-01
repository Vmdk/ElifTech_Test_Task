json.array!(@companies) do |company|
  json.extract! company, :id, :name, :earnings, :nesting_level, :master_company_id
  json.url company_url(company, format: :json)
end
