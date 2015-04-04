class AddSignatureToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :signature, :text
  end
end
