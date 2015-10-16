class CreateComponents < ActiveRecord::Migration
  def change
    create_table :nam_components do |t|
      t.string :ipaddress
      t.string :name
      t.string :component_type
      t.string :rule_model_id

      t.timestamps null: false
    end
  end
end
