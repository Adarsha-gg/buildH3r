#[starknet::interface]
trait ICounter<T> 
{
    fn get(self: @T) -> u128;
    fn increase(ref self: T);
    fn decrease(ref self: T);

}

#[starknet::contract]
mod Counter{
    use traits::Into;
    #[storage]
    struct Storage{
        number: u128
    }
    #[constructor]
    fn constructor(ref self: ContractState, number_: u128) {
        self.number.write(number_);
    }
    #[abi(embed_v0)]
      impl Counter of super::ICounter<ContractState>
      {
        fn get(self: @ContractState) -> u128 {  
            self.number.read()
        }
        fn increase(ref self: ContractState){   
            self.number.write( self.number.read() + 1 );
        }
        fn decrease(ref self: ContractState){  
            self.number.write( self.number.read() - 1 );
        }
        }
}