class AddHexIdToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :hexid, :string, unique: true
  end
end
