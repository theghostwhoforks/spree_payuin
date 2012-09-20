class CreatePayuinPaymentTransactions < ActiveRecord::Migration
  def change
    create_table :spree_payuin_payment_transactions do |t|
      t.string :transaction_id
      t.string :payment_id
      t.boolean :status
      t.string :checksum
      t.string :response
      t.integer :payment_method_id
      t.timestamps
    end
  end
end
