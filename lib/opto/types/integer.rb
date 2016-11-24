require_relative '../type'
require 'opto/extensions/snake_case'
require 'opto/extensions/hash_string_or_symbol_key'

if RUBY_VERSION < '2.1'
  using Opto::Extension::SnakeCase
  using Opto::Extension::HashStringOrSymbolKey
end

module Opto
  module Types
    # A number.
    #
    # Options
    #   :min - minimum allowed value (default 0, can be negative)
    #   :max - maximum allowed value
    #   :nil_is_zero : set to true if you want to turn a null value into 0
    class Integer < Opto::Type
      using Opto::Extension::HashStringOrSymbolKey unless RUBY_VERSION < '2.1'

      OPTIONS = {
        min: 0,
        max: nil,
        nil_is_zero: false
      }

      sanitizer :to_i do |value|
        value.nil? ? (options[:nil_is_zero] ? 0 : nil) : value.to_i
      end

      validator :min do |value|
        return nil if value.nil?
        if options[:min] && value < options[:min]
          "Too small. Minimum value is #{options[:min_length]}, Value is #{value}."
        end
      end

      validator :max do |value|
        return nil if value.nil?
        if options[:max] && value > options[:max]
          "Too large. Maximum value is #{options[:max]}, Value is #{value}."
        end
      end
    end
  end
end

