Tnp::Application.routes.draw do
  get 'searcher/searchq/:model/:qry' => 'searcher#searchq'
  resources :links

  resources :datapages

  get "list/getdata"
  get "list/index"
  get "list/parsedata"
  get "list/updatedata"
  
  resources :disps

  get '/list/:link_id' => 'list#send_desc', :as => 'send_desc'

  get '/list/search/:qry' => 'list#searchq', :as => 'searchq'
  
  root :to => "list#index"

end
