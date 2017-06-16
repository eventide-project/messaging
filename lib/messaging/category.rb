module Messaging
  module Category
    def self.included(cls)
      cls.extend Macro
    end

    def self.normalize(category)
      Casing::Camel.(category, symbol_to_string: true)
    end

    module Macro
      def category_macro(category)
        category = Category.normalize(category)
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
