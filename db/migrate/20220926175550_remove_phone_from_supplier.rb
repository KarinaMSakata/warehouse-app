class RemovePhoneFromSupplier < ActiveRecord::Migration[7.0]
  def change
    remove_column :suppliers, :phone, :integer
  end
end
