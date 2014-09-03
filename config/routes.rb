Pgpitter::Application.routes.draw do
  resources :statuses, only: [:create]

  resources :keys, only: [:show] do
    resources :statuses, only: [:index]
  end

  get "/about", to: "high_voltage/pages#show", id: "about"

  # statuses#show is hidden behind the hexid to maintain the small amount of
  # privacy that we think we have. This way people cannot just browse through
  # statuses by incrementing the ID.
  get "/:hexid(.:format)", to: "statuses#show", as: :hex
end
