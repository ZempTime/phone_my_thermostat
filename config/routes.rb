Rails.application.routes.draw do
  get 'dumb_phone/index'

  devise_for :users

  post 'twilio/message', to: 'twilio#receive_message'
  post 'twilio/call/intro', to: 'twilio#intro'
  post 'twilio/call/handleGather', to: 'twilio#handleGather'
  post 'twilio/call/setTemp', to: 'twilio#setTemp'
  get 'twilio/call/alertCall', to: 'twilio#alertCall'

  get 'main/signed_in'
  get 'main/not_signed_in'

  get 'alert/duration'

  root to: 'main#not_signed_in'
end
