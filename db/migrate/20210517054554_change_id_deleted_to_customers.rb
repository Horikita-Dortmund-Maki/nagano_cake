class ChangeIdDeletedToCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :id_deleted, :boolean, default: true, null: false
  end
end
