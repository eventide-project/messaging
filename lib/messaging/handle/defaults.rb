module Messaging
  module Handle
    module Defaults
      def self.strict
        Strict.get == 'on'
      end

      module Strict
        def self.get
          ENV.fetch(env_var, default)
        end

        def self.set(val)
          ENV[env_var] = val
        end

        def self.env_var
          'HANDLE_STRICT'
        end

        def self.default
          'off'
        end

        module Set
          def self.on
            Strict.set('on')
          end

          def self.off
            Strict.set('off')
          end
        end
      end
    end
  end
end
