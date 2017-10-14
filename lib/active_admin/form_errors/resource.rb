module ActiveAdmin
  module FormErrors
    module Resource
      attr_writer :form_errors

      def form_errors
        instance_variable_defined?(:@form_errors) ? @form_errors : namespace.form_errors
      end
    end
  end
end
