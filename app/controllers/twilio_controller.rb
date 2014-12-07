class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive_message
    @user = User.find_by(phone_number: params["From"].phony_formatted.gsub(/\s+/, ""))

    @message = @user.text_messages.new
    @message.body = params["Body"]

    if @message.save
      render :nothing => true, :status => 200, :content_type => 'text/html'
    else
      render :nothing => true, :status => 500, :content_type => 'text/html'
    end
  end
end
