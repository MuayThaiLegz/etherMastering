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

    function balanceOf(address _account)
        public view returns (uint256 balance) {
        return coinBalance[_account];
    }

    function transfer(address, _to, uint256 _amount) public returns (bool) {
        require(_to != 0x0);
        require(CoinBalance[msg.sender] > _amount);
        require(CoinBalance[_to] + _amount >= coinBalance[_to]);
        CoinBalance[msg.sender] -= _amount;
        CoinBalance[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function approve(address _authorizedAccount, uint256 _allowance)
        public returns (bool success) {
            allowances[msg.sender][_authorizedAccount] = _allowance;
            emit Approval(msg.sender, _authorizedAccount, _allowance);
            return true;
    }

    function transferFrom(address, _from,address, _to, uint256 _amount) public returns (bool success) {
        require(_to != 0x0);
        require(CoinBalance[_from] > _amount);
        require(CoinBalance[_to] + _amount >= coinBalance[_to]);
        require(_amount <= allowances[_from][msg.sender]);

        CoinBalance[msg.sender] -= _amount;
        CoinBalance[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }

    function allowance(address _authorizer, address _authorizedAccount) public view returns (uint256){

        return allowances[_authorizer][_authorizedAccount];
    }

    function mint(address _recipient, uint256 _mintedAmount) onlyOwner public {
        coinBalance[_recipient] += _mintedAmount;
        emit Transfer(owner, _recipient, _mintedAmount);
    }

    function freezeAccount(address target, bool freeze)
        onlyOwner public {

        frozenAccount[target] = freeze;
        emit FrozenAccount(target, freeze);
    }
/* 
    Althought the token constructor isn't part of the interface and consequently itn't 
    included in the standard, ERC20 recommends initializing a token with the following info.

    string public constant name = "Token Name";

    string public constant symbol = "MAN";

    uint8 public constant decimals = 18;
    



}
