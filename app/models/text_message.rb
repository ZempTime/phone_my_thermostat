class TextMessage < ActiveRecord::Base
  belongs_to :user
  after_create :converse_with_thermostat

  private
    def converse_with_thermostat
      ThermostatConverser.respond(self)
    end
end
