Pgpitter::Application.routes.draw do
  # statuses#show is hidden behind the hexid to maintain the small amount of
  # privacy that we think we have. This way people cannot just browse through
  # statuses by incrementing the ID.
  resources :statuses, only: [:create]
  get "/:hexid", to: "statuses#show", as: :hex
end
