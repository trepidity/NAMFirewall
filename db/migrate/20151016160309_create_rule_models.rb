class CreateRuleModels < ActiveRecord::Migration
  def change
    create_table :rule_models do |t|
      t.string :session_id

      add_index :nam_components, :rule_model_id

      t.timestamps null: false
    end
  end
end
