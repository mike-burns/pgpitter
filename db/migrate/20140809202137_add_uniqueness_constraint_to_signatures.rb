class AddUniquenessConstraintToSignatures < ActiveRecord::Migration
  def change
    add_index :signatures, [:signing_key_id, :signed_key_id], unique: true
  end
end
