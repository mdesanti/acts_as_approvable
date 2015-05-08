require 'active_record'
require 'active_support/inflector'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsApprovable
  if defined?(ActiveRecord::Base)
    require 'acts_as_approvable/extenders/approvable'
    require 'acts_as_approvable/approval'
    ActiveRecord::Base.extend ActsAsApprovable::Extenders::Approvable
  end
end
