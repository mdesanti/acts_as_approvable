module ActsAsApprovable
  module Approver
    def self.included(base)
      base.class_eval do
        has_many :approvals, class_name: 'ActsAsApprovable::Approval', dependent: :destroy, as: :approver
      end
    end

    def approver?
      true
    end

    def approve(object)
      approval = validate_approval_existance(object)
      approval.update_attributes!(approved: true)
    end

    def reject(object)
      approval = validate_approval_existance(object)
      approvals.where(resource: object).update_attributes!(approved: false)
    end

    def pending_approvals
      approvals.where(approved: nil)
    end

    def approved_approvals
      approvals.where(approved: true)
    end

    def rejected_approvals
      approvals.where(approved: false)
    end

    private
      def validate_approval_existance(object)
        approval = approvals.where(resource: object).first
        raise "#{self} has not been requested approval of #{object}" unless approval.present?
        approval
      end
  end
end
