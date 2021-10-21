pragma solidity 0.7.0;

contract owned {
    address owner;
        // Contract constructor: set owner
    constructor() {
        owner = msg.sender;
    }
        // Access control modifier
    modifier onlyOwner {
        require(msg.sender == owner,
            'Only the contract owner can call this function');
        _;
    }
}

contract mortal is owned {
    // contract
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}

contract Faucet is mortal {
    event Withdraw(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        require(withdraw_amount <= 0.1 ether);
        require(this.balance >= withdraw_amount,
                'Insufficient funds in faucet for withdrawal request');
        // send the amount to the address that requested Insufficient
        msg.sender.transfer(withdraw_amount);
        emit withdraw(msg.sender, withdraw_amount);
    }
    // Accept any incoming amount
    fallback () external payable {
        emit Deposit(msg.sender, msg.value);
    }
}