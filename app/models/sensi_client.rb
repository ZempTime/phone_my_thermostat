class SensiClient
  include HTTParty
  base_uri 'http://2c617bd9.ngrok.com'

  def temperature
    self.class.get("/temperature")
  end

  def desiredTemperature
    self.class.get("/desiredTemperature")
  end

  def desiredTemperature(temperature)
    self.class.post("/desiredTemperature", body: {temp: temperature.to_s}) 
  end

  def mode
    self.class.get("/mode")
  end

  def mode(mode)
    self.class.post("/mode", body: {mode:  mode} )
  end

  def away
    self.class.get("/away")
  end

  def away_on
    self.class.post("/away", body: {active: "true"})
  end

  def away_off
    self.class.post("/away", body: {active: "false"})
  end

  def thermostat
    self.class.get("/thermostat")
  end

end
