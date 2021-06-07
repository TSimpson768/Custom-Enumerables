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
end