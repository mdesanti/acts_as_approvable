module ActsAsApprovable
  module Approvable
    def self.included(base)
      base.class_eval do
        has_many :approvals, class_name: 'ActsAsApprovable::Approval', dependent: :destroy, as: :resource
        scope :approved, -> { joins(:approvals).where('approvals.approved = true') }
      end
    end

    def approvers
      approvals.includes(:approver).map(&:approver)
    end

    def approvable?
      true
    end

    def pending_approvals
      approvals.where(approved: nil)
    end

    def approved?
      approvals.where(approved: [false, nil]).empty?
    end

    def needs_approval_of(objects)
      # Wraps its argument in an array unless it is already an array (or array-like).
      objects = Array.wrap(objects)
      raise "All objects must act as approvers" unless objects.all? { |a| a.respond_to?('approver?') }
      objects.each { |o| ActsAsApprovable::Approval.create!(resource: self, approver: o) }
    end
  end
end
