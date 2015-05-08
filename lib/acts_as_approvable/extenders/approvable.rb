module ActsAsApprovable
  module Extenders
    module Approvable

      def acts_as_approvable
        require 'acts_as_approvable/approvable'
        include ActsAsApprovable::Approvable
      end

      def acts_as_approver
        require 'acts_as_approvable/approver'
        include ActsAsApprovable::Approver
      end
    end
  end
end
