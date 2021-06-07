require '../enumerable'

describe Enumerable do
  describe '#my_select' do
    context 'When operating on an array' do
      subject(:select_array) { [1,2,3,4,5,6,7,8,9,10] }
      it 'Returns an Enumerator if no block is given' do
        result = select_array.my_select
        expect(result).to be_instance_of(Enumerator)
        
      end
    end

  end
end