class ActsAsApprovableMigration < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.references :resource, polymorphic: true
      t.references :approver, polymorphic: true
      t.boolean :approved, nil: true, default: nil
    end
    add_index 'approvals',
              ['resource_id', 'resource_type', 'approver_id', 'approver_type'],
              unique: true,
              name: 'one_approval_per_approver_and_resource'
  end
end
