class RenameOrganizationNameToOrganizationLogin < ActiveRecord::Migration
  def change
    rename_column :invites, :organization_name, :organization_login
  end
end
