class AddUniquenessConstraintToKeys < ActiveRecord::Migration
  def change
    add_index :keys, :keyid, unique: true
  end
end
