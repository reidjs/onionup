class AddMorePingData < ActiveRecord::Migration[5.1]
  def change
    add_column(:pings, :loadTime, :integer)
    add_column(:pings, :loaded, :boolean) 
  end
end
