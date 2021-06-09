# frozen_string_literal: true

require '../enumerable'

describe Enumerable do
  describe '#my_select' do
    context 'When operating on an array' do
      subject(:select_array) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
      it 'Returns an Enumerator if no block is given' do
        result = select_array.my_select
        expect(result).to be_instance_of(Enumerator)
      end

      it 'Returns an array of all elements for which a block is true' do
        expected_result = select_array.select(&:even?)
        result = select_array.my_select(&:even?)
        expect(result).to eq(expected_result)
      end
    end

    context 'When operating on a hash' do
      subject(:select_hash) { { 'a' => 1, 'b' => 2, 'c' => 3, 'd' => 5 } }

      it 'Returns an Enumerator if no block is given' do
        result = select_hash.my_select
        expect(result).to be_instance_of(Enumerator)
      end

      it 'Returns an array of all elementf for which the given block is true' do
        expected_result = select_hash.to_enum.select { |pair| pair[1].odd? }
        result = select_hash.my_select { |pair| pair[1].odd? }
        expect(result).to eq(expected_result)
      end
    end
  end

  describe '#my_all?' do
    context 'For an enumerable with no falsey values' do
      subject(:all_array) { [3, 6, 9, 12, 15, 24, 30, 42, 69] }
      it 'Retruns true if no block is given' do
        expect(all_array).to be_my_all
      end

      it 'Returns true if the given block returns true for all members' do
        expect(all_array).to(be_my_all { |value| value % 3 == 0 })
      end

      it 'Returns false if the given block is false for any member' do
        expect(all_array).not_to(be_my_all(&:even?))
      end
    end

    context 'When the enumarable contains a falsey value' do
      subject(:all_array_falsey) { [5, 8, 3, 2, nil, 0] }
      it 'Returns false when no block is given' do
        expect(all_array_falsey).not_to be_my_all
      end
    end
  end

  describe 'my_any?' do
    context 'For an array with at least 1 truthy value' do
      subject(:any_array) { [nil, 3, 6, 42, 700, 42_069] }
      it 'Returns true if no block is given' do
        expect(any_array).to be_my_any
      end

      it 'Returns true if any value causes the given block to return true' do
        expect(any_array).to(be_my_any { |obj| obj == 700 })
      end

      it 'Returns false if the given block is false for all members' do
        expect(any_array).not_to(be_my_any { |obj| obj == 69 })
      end
    end

    context 'For an array containing only falsey values' do
      subject(:any_false) { [false, false, nil] }
      it 'Returns false when no block is given' do
        expect(any_false).not_to be_my_any
      end

      it 'Returns true if the given block returns true for any member' do
        expect(any_false).to(be_my_any(&:nil?))
      end
    end
  end

  describe '#my_none?' do
    context 'For an array containing truthy elements' do
      subject(:none_array) { [1, 2, 3, 4, 5, 6, 7] }
      it 'returns false when given a block' do
        expect(none_array).not_to be_my_none
      end

      it 'Returns false if any element causes the given block to be true' do
        expect(none_array).not_to(be_my_none { |object| object > 6 })
      end

      it 'Returns true if the block is false for all elements' do
        expect(none_array).to(be_my_none { |object| object > 10 })
      end
    end

    context 'When an array only contains falsey elements' do
      subject(:none_false) { [false, false, false] }
      it 'Returns true if no block is given' do
        expect(none_false).to be_my_none
      end

      it 'Returns true if block is false for all elements' do
        expect(none_false).to be_my_none(&:nil?)
      end
    end
  end

  describe '#my_count' do
    subject(:count_array) { [3, 6, 9, 4, 2, 4, 7] }
    it 'Return the number of elements if no block or argument is given' do
      expected_result = count_array.count
      result = count_array.my_count
      expect(result).to eq(expected_result)
    end

    it 'Returns the number of elements that fufill the given block' do
      expected_result = count_array.count { |object| object % 3 == 0 }
      result = count_array.my_count { |object| object % 3 == 0 }
      expect(result).to eq(expected_result)
    end

    it 'Returns the number of elements equal to the given argument' do
      expected_result = count_array.count(4)
      result = count_array.my_count(4)
      expect(result).to eq(expected_result)
    end
  end

  describe '#my_map' do
    subject(:numbers) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 42, 69] }
    it 'Returns an enumerator if no block is given' do
      result = numbers.my_map
      expect(result).to be_instance_of(Enumerator)
    end

    it 'Returns an array containing the result of executing the given block once for every element' do
      expected_result = numbers.map { |object| object * 3 }
      result = numbers.my_map { |object| object * 3 }
      expect(result).to eq(expected_result)
    end
  end

  describe '#my_inject' do
    subject(:numbers) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 42, 69] }
    it 'Produces the same result as inject with no memory' do
      expected_result = numbers.reduce { |memory, number| memory + number }
      result = numbers.my_inject { |memory, number| memory + number }
      expect(result).to eq(expected_result)
    end

    it 'Produces the same result as inject with memory' do
      initial_mem =  100
      expected_result = numbers.reduce(initial_mem) { |memory, number| memory + number }
      result = numbers.my_inject(initial_mem) { |memory, number| memory + number }
      expect(result).to eq(expected_result)
    end
  end

  describe '#multiply_els' do
    subject(:array) { [2, 4, 5] }
    it 'returns 40' do
      result = array.multiply_els(array)
      expect(result).to eq(40)
    end
  end

  describe '#my_map_proc' do
    subject(:numbers) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 42, 69] }
    it 'Returns an array containing the result of executing the given proc once for every element' do
      my_proc = proc { |num| num * 3 }
      expected_result = numbers.map { |object| object * 3 }
      result = numbers.my_map_proc(my_proc)
      expect(result).to eq(expected_result)
    end

    it 'Does the same if given a lambda' do
      my_lambda = ->(obj) { obj * 4 }
      expected_result = numbers.map { |object| object * 4 }
      result = numbers.my_map_proc(my_lambda)
      expect(result).to eq(expected_result)
    end
  end
end
