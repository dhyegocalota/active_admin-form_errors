require 'active_support/core_ext'
require 'active_admin'

module ActiveAdmin
  module FormErrors
    autoload :Version, 'active_admin/form_errors/version'
  end
end

require 'active_admin/form_errors/engine'
require 'active_admin/form_errors/form'
require 'active_admin/form_errors/resource'

ActiveAdmin::Application.inheritable_setting :form_errors, true
ActiveAdmin::Views::ActiveAdminForm.prepend(ActiveAdmin::FormErrors::Form)
ActiveAdmin::Resource.include(ActiveAdmin::FormErrors::Resource)
