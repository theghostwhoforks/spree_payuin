class CreatePayuinPayments < ActiveRecord::Migration
  def change
    create_table :spree_payuin_payments do |t|
      t.string :payment_id
      t.string :mode
      t.string :status
      t.string :key
      t.string :transaction_id
      t.float :amount
      t.string :checksum
      t.string :response
      t.timestamps
    end
  end
end
