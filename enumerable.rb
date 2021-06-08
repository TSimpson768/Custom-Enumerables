require 'pry'
module Enumerable
  BLANK_ARGUMENT = Object.new.freeze
  def my_each
    enum = to_enum
    return unless block_given?

    for i in enum do
      yield i
    end
  end

  def my_each_with_index
    enum = to_enum
    return unless block_given?

    index = 0
    for object in enum do
      yield object, index
      index += 1
      
    end
  end

  # A recreation of Enumerable#select.
  def my_select
    enum = to_enum
    return enum unless block_given?

    return_array = []
    enum.my_each { |object| return_array.push(object) if yield object }
    return_array
  end

  # A recreation of Enumerable#all?. Return true if block is true for all of Enum, else return false.
  # If no block, return result of all?{|object| object}
  def my_all?
    enum = to_enum
    if block_given?

      enum.my_each { |object| return false unless yield object }
    else
      block = lambda { |x| x }
      enum.my_each { |object| return false unless block.call(object) }
    end
    true
  end

  def my_any?
    enum = to_enum
    if block_given?
      enum.my_each { |object| return true if yield object }
    else
      block = lambda { |x| x }
      enum.my_each { |object| return true if block.call(object) }
    end
    false
  end

  def my_none?
    enum = to_enum
    if block_given?
      enum.my_each { |object| return false if yield object }
    else
      block = lambda { |x| x }
      enum.my_each {|object| return false if block.call(object) }
    end
    true
  end

  def my_count(item = BLANK_ARGUMENT)
    enum = to_enum
    result = 0
    if block_given?
      enum.my_each { |object| result += 1 if yield object }
    elsif item == BLANK_ARGUMENT
      enum.my_each { |object| result += 1 if object }
    else
      enum.my_each { |object| result += 1 if object == item }
    end
    result
  end

  def my_map
    enum = to_enum
    return enum unless block_given?

    result = []
    enum.my_each { |object| result.push(yield object) }
    result
  end

  def my_inject(initial = first)
    enum = to_enum
    enum = drop(1).to_enum if initial == first
    memory = initial
    enum.my_each { |object| memory = yield memory, object }
    memory
  end
end

numbers = [1,2,3]
hash_brown = {:bacon => 2,
              :link_sausage => 2,
              :lorne_sausage =>1,
              :black_pudding => 3,
              :haggis => 5,
              :spam => 42 }
numbers.each {|n| p n }
numbers.my_each{|n| p n}
hash_brown.each {|k, v| p "#{k} => #{v}"}
hash_brown.my_each {|k, v| p "#{k} => #{v}"}

numbers.each_with_index { |obj, i| puts "#{i}, #{obj}"}
numbers.my_each_with_index { |obj, i| puts "#{i}, #{obj}"}
hash_brown.each_with_index { |obj, i| puts "#{i}, #{obj}"}
hash_brown.my_each_with_index { |obj, i| puts "#{i}, #{obj}"}