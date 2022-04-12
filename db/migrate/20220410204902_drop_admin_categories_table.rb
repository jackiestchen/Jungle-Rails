class DropAdminCategoriesTable < ActiveRecord::Migration
  def up
    drop_table :admin_categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
