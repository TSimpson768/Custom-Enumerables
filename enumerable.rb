module Enumerable
  def my_each
    enum = self.to_enum
    return unless block_given?

    for i in enum do
      yield i
    end
  end

  def my_each_with_index
    enum = self.to_enum
    return unless block_given?

    index = 0
    for object in enum do
      yield object, index
      index += 1
      
    end
  end

  # A recreation of Enumerable#select. 
  def my_select
    enum = self.to_enum
    return enum unless block_given?

    return_array =[]
    for object in enum do
      if yield object
        return_array.push(object)
      end
    end
    return_array
  end

  # A recreation of Enumerable#all?. Return true if block is true for all of Enum, else return false.
  # If no block, return result of all?{|object| object}
  def my_all?
    enum = self.to_enum
     if block_given?
      for object in enum do
        return false unless yield object
      end
     else
        block = lambda { |x| x }
        for object in enum do
          return false unless block.call(object)
        end
     end
     true
  end

  def my_any?
    
  end

  def my_none?
    
  end

  def my_count
    
  end

  def my_map
    
  end

  def my_inject
    
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