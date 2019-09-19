Rails.application.routes.draw do
  resources :leads, only: %i(new create)

  root 'leads#new'
end
