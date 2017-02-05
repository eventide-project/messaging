module Messaging
  module Category
    def self.included(cls)
      cls.extend Macro
    end

    module Macro
      def category_macro(category)
        category = Casing::Camel.(category, symbol_to_string: true)
        self.send :define_method, :category do
          @category ||= category
        end

        self.send :define_method, :category= do |category|
          @category = category
        end
      end
      alias :category :category_macro
    end
  end
end
