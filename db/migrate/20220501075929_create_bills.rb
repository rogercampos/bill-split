class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.jsonb :data
      t.text :public_token

      t.timestamps
    end

    add_index :bills, :public_token
  end
end
