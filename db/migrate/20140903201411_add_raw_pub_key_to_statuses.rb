class AddRawPubKeyToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :raw_pub_key, :text
  end
end
