module Enumerable
  def my_each
    if block_given?
      length = self.length
      if self.class == Hash
        keys = self.keys
        for i in 0..length do
          yield keys[i], self[keys[i]]
        end
      else
        for i in 0..length do
          yield self[i]
        end
      end
    end
  end

  def my_each_with_index
    
  end

  def my_select
    
  end

  def my_all?
    
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
numbers.each {|n| puts n }
numbers.my_each{|n| puts n}