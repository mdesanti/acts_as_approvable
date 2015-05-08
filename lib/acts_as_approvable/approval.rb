module ActsAsApprovable
  class Approval < ::ActiveRecord::Base
    belongs_to :resource, polymorphic: true
    belongs_to :approver, polymorphic: true
  end
end
