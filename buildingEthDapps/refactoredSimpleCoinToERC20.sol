pragma solidity 0.7.0;

import 'simpleCoin_ERCDUB.sol';


contract ERC20 {

    uint256 public totalSupply;

    function balanceOf(address _owner) public view returns (uint256 balance);

    function transfer(address _to, uint256 _value) public view returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) public view returns (bool success);

    function approve(address _spender, uint256 _value) public view returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    
    event Approval(address indexed _owner, address indexed _to, uint256 _spender);   
}

// SimpleCoin refactored to an ERC20 token

contract SimpleCoin is Ownable, ERC20 {

    mapping (address => uint256)
        internal coinBalance;

    mapping (address => mapping
        (address => uint256)) internal allowances;

    mapping (address => bool) public frozenAccount;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed authorizer, address indexed authorized, uint256 value);   
    
    event FrozenAccount(address target, bool frozen);

    constructor(uint256 _initialSupply) public {
        owner = msg.sender;

        mint(owner, _initialSupply);
    }

    
}