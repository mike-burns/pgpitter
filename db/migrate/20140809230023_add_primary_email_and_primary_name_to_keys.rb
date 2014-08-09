class AddPrimaryEmailAndPrimaryNameToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :primary_email, :string
    add_column :keys, :primary_name, :string
  end
end
