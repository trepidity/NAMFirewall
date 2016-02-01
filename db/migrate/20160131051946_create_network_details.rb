class CreateNetworkDetails < ActiveRecord::Migration
  def change
    create_table :network_details do |t|
      t.boolean :fw_separates_idp
      t.boolean :fw_separates_ag
      t.boolean :fw_separates_ac
      t.references :rule_model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
