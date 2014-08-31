Pgpitter::Application.routes.draw do
  # statuses#show is hidden behind the hexid to maintain the small amount of
  # privacy that we think we have. This way people cannot just browse through
  # statuses by incrementing the ID.
  resources :statuses, only: [:create]
  resources :keys, only: [:show]
  get "/about", to: "high_voltage/pages#show", id: "about"
  get "/:hexid", to: "statuses#show", as: :hex
end
