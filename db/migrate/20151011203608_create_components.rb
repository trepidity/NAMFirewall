class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :ipaddress
      t.string :name
      t.string :type

      t.timestamps null: false
    end
  end
end
