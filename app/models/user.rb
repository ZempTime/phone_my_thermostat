class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :thermostat
  has_many :text_messages

  phony_normalize :phone_number, :default_country_code => 'US'

  def country_code
    'US'
  end
end
