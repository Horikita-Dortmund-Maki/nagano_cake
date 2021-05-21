class ChangePaymentMethodOfOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :payment_method, :integer, default: 0
  end
end
