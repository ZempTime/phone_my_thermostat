class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
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

  def intro
    ctr = $sensi.temperature
    current_temp = ctr.body.to_i

    dtr = $sensi.getDesiredTemperature
    desired_temp = dtr.body.to_i

    response = Twilio::TwiML::Response.new do |r|
      r.Gather :numDigits => '1', :action => '/twilio/call/handleGather' do |s|
        s.Say "Hey, this is Sen See. Your current temperature is #{current_temp} degrees, and I'm set for #{desired_temp} degrees.", :voice => 'alice'
        s.Say "Press 1 to set a new desired temperature.", :voice => 'alice'
        s.Say "Press 2 to enable away mode.", :voice => 'alice'
        s.Say "Press 3 if you wanna build a snow man.", :voice => 'alice'
        s.Say "Press any other key to start over.", :voice => 'alice'
        s.Pause 1
      end
    end

    render_twiml response
  end

  def handleGather
    if params["Digits"] == '1'

      response = Twilio::TwiML::Response.new do |r|
        r.Gather :numDigits => '2', :action => '/twilio/call/setTemp' do |s|
          s.Say "Dial in your desired temperature between 45 and 98 degrees.", :voice => 'alice'
          s.Pause 1
        end
      end

      render_twiml response
    elsif params["Digits"] == '2'
      $sensi.away_on

      response = Twilio::TwiML::Response.new do |r|
        r.Say "Away mode enabled. I'll miss you. Come back soon. I love you. I, love you.", :voice => 'alice'
      end

      render_twiml response
    elsif params["Digits"] == '3'

      response = Twilio::TwiML::Response.new do |r|
        r.Play 'http://www.televisiontunes.com/themesongs/Frozen%20-%20Do%20You%20Want%20to%20Build%20a%20Snowman.mp3'
      end

      render_twiml response
    end
  end

  def setTemp
    temp = params["Digits"]

    if valid_temperature?(temp.to_i)
      $sensi.desiredTemperature(temp.to_i.to_s)

      response = Twilio::TwiML::Response.new do |r|
        r.Say "Your temperature has been set to #{temp}.", :voice => 'alice'
        r.Say "Nice talking with you. Goodbye!", :voice => 'alice'
      end

      render_twiml response
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Gather :numDigits => '2', :action => '/twilio/call/setTemp' do |s|
          s.Say "Dial in your desired temperature between 45 and 98 degrees.", :voice => 'alice'
          s.Pause 1
        end
      end

      render_twiml response
    end
  end

  private

    def valid_temperature?(temp)
      temp.between?(ThermostatConverser::MIN_TEMP, ThermostatConverser::MAX_TEMP)
    end

end


#@user = User.find_by(phone_number: params["From"].phony_formatted.gsub(/\s+/, ""))

#@message = @user.call_messages.new
#@message.body = params["Body"]

#if @message.save
#render :nothing => true, :status => 200, :content_type => 'text/html'
#else
#render :nothing => true, :status => 500, :content_type => 'text/html'
#end
