Pgpitter::Application.routes.draw do
  resources :statuses, only: [:create, :show]
end