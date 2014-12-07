class CreateCallMessages < ActiveRecord::Migration
  def change
    create_table :call_messages do |t|
      t.integer :user_id
      t.string :body

      t.timestamps
    end
  end
end
