class MainController < ApplicationController
  before_action :signed_in, :authenticate_user!

  def signed_in
  end

  def not_signed_in
  	@sensi = $sensi
  end
end
