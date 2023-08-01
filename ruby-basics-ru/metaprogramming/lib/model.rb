# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.instance_variable_set '@schema', {}
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :schema

    def convert_value(value, type)
      type_conversions = {
        integer: ->(v) { v.to_i },
        string: ->(v) { v.to_s },
        datetime: ->(v) { DateTime.parse(v) },
        boolean: ->(v) { v != false && !v.nil? }
      }

      value.nil? || type.nil? ? value : type_conversions[type].call(value)
    end

    def attribute(name, options = {})
      @schema[name] = options

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", self.class.convert_value(value, options[:type])
      end
    end
  end

  def initialize(attributes = {})
    self.class.schema.each do |key, options|
      value = attributes.key?(key) ? attributes[key] : options[:default]
      send "#{key}=", value
    end
  end

  def attributes
    self.class.schema.keys.each_with_object({}) do |key, attributes|
      attributes[key] = send key
    end
  end
end
# END
