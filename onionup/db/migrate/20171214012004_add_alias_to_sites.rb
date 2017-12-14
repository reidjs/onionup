class AddAliasToSites < ActiveRecord::Migration[5.1]
  def change
    add_column :sites, :alias, :string
  end
end
