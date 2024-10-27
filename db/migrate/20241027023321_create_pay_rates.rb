class CreatePayRates < ActiveRecord::Migration[7.2]
  def change
    create_table :pay_rates do |t|
      t.string :rate_name, null: false
      t.float :base_rate_per_client, null: false

      t.timestamps
    end
  end
end
