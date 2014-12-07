require 'twilio-ruby'

class TwilioClient
  ACCOUNT_SID = Rails.application.secrets.twilio_account_sid
  AUTH_TOKEN =  Rails.application.secrets.twilio_auth_token


  def self.send_message(to:, body:)
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    client.messages.create(
      from: '+13148992442',
      to: to,
      body: body
    )
  end

end



