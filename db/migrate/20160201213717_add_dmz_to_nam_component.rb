class AddDmzToNamComponent < ActiveRecord::Migration
  def change
    add_column :nam_components, :dmz, :string
  end
end
