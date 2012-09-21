class CreatePayuinPaymentTransactions < ActiveRecord::Migration
  def change
    create_table :spree_payuin_payment_transactions do |t|
      t.string :status
      t.string :response
      t.integer :payment_method_id
      t.timestamps
    end
  end
end
