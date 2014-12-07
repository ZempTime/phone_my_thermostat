class ChangeThermostatState < ActiveRecord::Migration
  def change
    remove_column :thermostats, :system_mode, :string
    remove_column :thermostats, :current_temp, :integer
    remove_column :thermostats, :cool_temp, :integer
    remove_column :thermostats, :heat_temp, :integer

    add_column :thermostats, :temp, :integer
    add_column :thermostats, :mode, :string
    add_column :thermostats, :desiredTemp, :string
  end
end
