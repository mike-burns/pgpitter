class AddHexidToExistingStatuses < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE statuses
      SET hexid = substr(md5(body), 1, 8)
      WHERE hexid IS NULL
    SQL
  end

  def down
  end
end
