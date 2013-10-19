json.array!(@links) do |link|
  json.extract! link, :pageno, :date, :html, :date_added
  json.url link_url(link, format: :json)
end
