class CreatePayuinPayments < ActiveRecord::Migration
  def self.up
    create_table :spree_payuin_payments do |t|
      t.string :payment_id
      t.string :mode
      t.string :status
      t.string :key
      t.string :transaction_id
      t.float :amount
      t.string :checksum
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_payuin_payments
  end
end
