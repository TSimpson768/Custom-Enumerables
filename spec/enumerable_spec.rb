require '../enumerable'

describe Enumerable do
  describe '#my_select' do
    context 'When operating on an array' do
      subject(:select_array) { [1,2,3,4,5,6,7,8,9,10] }
      it 'Returns an Enumerator if no block is given' do
        result = select_array.my_select
        expect(result).to be_instance_of(Enumerator)
      end

      it 'Returns an array of all elements for which a block is true' do
        expected_result = select_array.select { |number| number.even? }
        result = select_array.my_select { |number| number.even? }
        expect(result).to eq(expected_result)
        
      end
    end

    context 'When operating on a hash' do
      subject(:select_hash) { {"a" => 1, "b" => 2, "c" => 3, "d" => 5} }

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

      xit 'Returns true if the given block returns true for all members' do
        expect(all_array).to(be_my_all { |value| value % 3 == 0})
      end
 
      xit 'Returns false if the given block is false for any member' do
        expect(all_array).not_to(be_my_all { |value| value.even? })
      end
    end

    context 'When the enumarable contains a falsey value' do
      subject(:all_array_falsey) { [5, 8, 3, 2, nil, 0] }
      xit 'Returns false when no block is given' do
        expect(all_array_falsey).not_to be_my_all
      end
    end

  end
end