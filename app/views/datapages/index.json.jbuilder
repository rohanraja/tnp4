json.array!(@datapages) do |datapage|
  json.extract! datapage, :url, :html
  json.url datapage_url(datapage, format: :json)
end
