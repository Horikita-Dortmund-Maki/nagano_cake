class ChangeIdDeletedOfCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :id_deleted, :boolean, default: true
  end
end
