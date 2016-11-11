module Opto
  module Extension
    module SnakeCase
      refine String do
        def snakecase
          gsub(/::/, '/')
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr('-', '_').
          gsub(/\s/, '_').
          gsub(/__+/, '_').
          downcase
        end

        alias_method :underscore, :snakecase
        alias_method :snakeize, :snakecase
      end
    end
  end
end