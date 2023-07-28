# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new %w[one two three]
  end

  def test_add_item_to_stack
    @stack.push! 'four'

    expected_items = %w[one two three four]
    assert { @stack.size == expected_items.size }
    assert { @stack.to_a == expected_items }
  end

  def test_delete_item_from_stack
    item = @stack.pop!

    expected_items = %w[one two]
    assert { @stack.size == expected_items.size }
    assert { @stack.to_a == expected_items }
    assert { item == 'three' }
  end

  def test_clear_stack
    @stack.clear!

    expected_items = []
    assert { @stack.size == expected_items.size }
    assert { @stack.to_a == expected_items }
  end

  def test_empty_method
    empty_stack = Stack.new []

    assert { @stack.empty? == false }
    assert { empty_stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
