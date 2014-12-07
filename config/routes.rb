Rails.application.routes.draw do
  devise_for :users

  post 'twilio/message', to: 'twilio#receive_message'

  get 'main/signed_in'
  get 'main/not_signed_in'
  root to: 'main#not_signed_in'
end
