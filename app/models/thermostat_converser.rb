class ThermostatConverser

  #execute a given strategy
  #send a response

  TARGET_QUERY = "target"
  CURRENT_QUERY = "current"
  AWAY_COMMAND = "away"
  MIN_TEMP = 44
  MAX_TEMP = 99

# can move these into { target_query: { matches: ["target"], type: "QueryTarget"} }

  def self.respond(message)
    message_type = Identifier.execute(message)

    response = "ThermostatConverser::#{message_type}".constantize.execute(message)

    TwilioClient.send_message(
      to: message.user.phone_number,
      body: response
    )
  end

  class QueryTarget
    def self.execute(message)
      response = $sensi.desiredTemperature
      target_temp = response.body
      "Your place is set to #{target_temp} - omg"
    end
  end

  class SetTarget
    def self.execute(message)
      target = message.body.to_i
      response = $sensi.desiredTemperature(target)
      "#{target}! Your Place! Sounds cool."
    end
  end

  class QueryCurrent
    def self.execute(message)
      response = $sensi.temperature
      current_temp = response.body
      "Your place is currently #{current_temp}. And your happiness sickens me."
    end
  end

  class InvalidSetTarget
    def self.execute(message)
      "Sorry! You can only set me between #{MIN_TEMP}-#{MAX_TEMP}!"
    end
  end

  class SetAway
    def self.execute(message)
      $sensi.away_on
      "Away mode engaged. I'll miss you! Come back soon!"
    end
  end

  class Menu
    def self.execute(message)
<<EOF
Commands:
away = set thermostat to away mode
current = get current temp
target = get target temp
# = set target temp to #
EOF
    end
  end

  class Identifier
    def self.execute(message)
      if message.body =~ /\d{2}/
        if message.body.to_i.between?(MIN_TEMP + 1, MAX_TEMP - 1)
          "SetTarget"
        else
          "InvalidSetTarget"
        end

      elsif included?(TARGET_QUERY, message.body)
        "QueryTarget"
      elsif included?(CURRENT_QUERY, message.body)
        "QueryCurrent"
      elsif included?(AWAY_COMMAND, message.body)
        "SetAway"
      else
        "Menu"
      end
    end

    def self.included?(option, body)
      option.include?(grab_first_word(body))
    end

    def self.grab_first_word(body)
      body.scan(/^([\w\-]+)/).first.first.downcase
    end
  end
end
