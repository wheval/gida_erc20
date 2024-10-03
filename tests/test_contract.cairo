use starknet::{ContractAddress, contract_address_const};

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
use gida_erc20::erc20::{IERC20Dispatcher, IERC20DispatcherTrait};

#[derive(Drop, Serde)]
struct ERC20Args{
    name: ByteArray,
    symbol:ByteArray,
}
 const TOKEN_NAME: ByteArray = "GIDA TOKEN";
 const TOKEN_SYMBOL: ByteArray ="GIDA";
fn deploy_contract(name: ByteArray) -> ContractAddress {
    let class_hash = declare(name).unwrap().contract_class();
    let mut constructor_args = array![];
    let args = ERC20Args {name: "GIDA TOKEN", symbol: "GIDA"};
    args.serialize(ref constructor_args)
    let address = class_hash.deploy(@constructor_args).unwrap();
    address
}

#[test]
fn deploy_erc20(){
    let contract_address = deploy_contract("ERC20");
    let erc20 = IERC20Dispatcher(contract_address);
    assert!(erc20.get_name() == "GIDA TOKEN", "INVALID NAME")
}

#[test]
fn test_mint(account: ContractAddress, amount: u32){
    let contract_address = deploy_contract("ERC20");
    let erc20 = IERC20Dispatcher(contract_address);
    let account = contract_address_const::<'wheval'>;
    erc20.mint(account, amount: 2000)
    assert!(erc20.balance_of(account) == 2000, "INCORRECT BALANCE");
}