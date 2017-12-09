class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      t.integer :site_id
      t.boolean :status
      t.string :response

      t.timestamps
    end
  end
end
