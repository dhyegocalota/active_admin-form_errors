module ActiveAdmin
  module FormErrors
    module Form
      def build(resource, options = {}, &block)
        wrapped_block =
          if !form_errors_config
            block
          elsif block_given?
            proc do |f|
              add_semantic_errors(resource)
              instance_eval(&block)
            end
          else
            proc { |f| add_semantic_errors(resource) }
          end

        super(resource, options, &wrapped_block)
      end

      def add_semantic_errors(resource)
        semantic_errors(*parse_resource_errors(resource))
      end

      def parse_resource_errors(resource)
        if form_errors_config.respond_to?(:call)
          instance_exec(&form_errors_config)
        else
          resource.errors.keys
        end
      end

      def form_errors_config
        respond_to?(:active_admin_config) ? active_admin_config.form_errors : ActiveAdmin.application.form_errors
      end
    end
  end
end
