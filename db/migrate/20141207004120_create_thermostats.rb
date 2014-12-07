class CreateThermostats < ActiveRecord::Migration
  def change
    create_table :thermostats do |t|
      t.integer :user_id
      t.string :system_mode
      t.integer :current_temp
      t.integer :cool_temp
      t.integer :heat_temp

      t.timestamps
    end
  end
end
