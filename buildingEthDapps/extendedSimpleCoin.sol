pragma solidity >=0.4.0 <0.8.0;

contract SimpleCoin {
    mapping (address => uint256) public coinBalance;

    mapping (address => mapping (address => uint256)) public allowance;

    mapping (address => bool) public frozenAccount;
    address public owner;


    event Tranfer(address indexed from, address indexed to, uint256 value);
    event FrozenAccount(address target, bool frozen);

    modifer onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }

    constructor(uint256 _initialSuppluy)
}