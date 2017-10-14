module ActiveAdmin
  module FormErrors
    module Form
      def build(resource, options = {}, &block)
        wrapped_block =
          if active_admin_config.form_errors == false
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
        if active_admin_config.form_errors.respond_to?(:call)
          instance_exec(&active_admin_config.form_errors)
        else
          resource.errors.keys
        end
      end
    end
  end
end
