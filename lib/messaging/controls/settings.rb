module Messaging
  module Controls
    module Settings
      def self.example
        ::Settings.build(data)
      end

      def self.data
        {
          some_setting: 'some setting value',
          some_other_setting: 'some other setting value'
        }
      end
    end
  end
end
