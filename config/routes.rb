Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"
  resources :users,only:[:index, :show, :edit]
  resources :books
  patch 'users/:id' =>'users#update',as:'update_user'
  get 'home/about'=>'homes#about',as:'about'
  get 'homes_index'=>'homes#index',as:'home'
  delete '/books'=>'books#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
