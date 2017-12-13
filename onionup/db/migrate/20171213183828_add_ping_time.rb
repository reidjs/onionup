class AddPingTime < ActiveRecord::Migration[5.1]
  def change
    add_column(:pings, :responseTime, :integer) 
  end
end
