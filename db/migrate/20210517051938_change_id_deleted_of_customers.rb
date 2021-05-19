class ChangeIdDeletedOfCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :id_deleted, :boolean, default: false, null: false
  end
end
 