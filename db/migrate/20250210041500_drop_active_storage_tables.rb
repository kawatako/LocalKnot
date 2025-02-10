class DropActiveStorageTables < ActiveRecord::Migration[7.2]
  def up
    drop_table :active_storage_variant_records
    drop_table :active_storage_attachments
    drop_table :active_storage_blobs
  end

  def down
    # Active Storage のテーブルを再作成するマイグレーションをここに記述
    # (通常はロールバックしないので、省略可)
    raise ActiveRecord::IrreversibleMigration
  end
end