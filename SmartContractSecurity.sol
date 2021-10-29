

/* Defensice Programming as a style of programming that is particularly well suited to smart contracts.
It emphasizes the following, all of which are best practices: Minimalism/simplicity: Code reuse:
Code quality: Readability/auditability: Test coverage.*/
pragma solidity 0.7.0;

contract EtherGame {
    
    uint public payoutMileStone1 = 3 ether;
    
    uint public mileStoneReward = 2 ether;

    uint public payoutMileStone2 = 5 ether;
    
    uint public mileStone2Reward = 3 ether;
    
    uint public finalMileStone = 10 ether;
    
    uint public finalReward = 5 ether;
    
    mapping(address => uint) redeemableEther;
    
    function play() public payable {
        
        require(msg.value == 0.5 ether);
        
        uint currentBalance = msg.sender.balance + msg.value;
        
        require(currentBalance <= finalMileStone);
        
        
        if (currentBalance == payoutMileStone1) {
            redeemableEther[msg.sender] += mileStoneReward;
            
        }
    
        else if (currentBalance == payoutMileStone2) {
            redeemableEther[msg.sender] += finalReward;
        }
    
        return;
    }
    
    function claimReward() public {
        require(msg.sender.balance == finalMileStone);
        
        require(redeemableEther[msg.sender] > 0);
        
        redeemableEther[msg.sender] = 0;
        msg.sender.transfer(finalReward);
    }
    
}


contract PreventEtherGame {
    
    uint public payoutMileStone1 = 3 ether;
    
    uint public mileStoneReward = 2 ether;

    uint public payoutMileStone2 = 5 ether;
    
    uint public mileStone2Reward = 3 ether;
    
    uint public finalMileStone = 10 ether;
    
    uint public finalReward = 5 ether;
    
    uint public depositWei;
    
    mapping (address => uint) redeemableEther;
    
    function play() public payable {
        
        require(msg.value == 0.5 ether);
        
        uint currentBalanceP = depositWei = msg.value;
        
        require(currentBalanceP <= finalMileStone);
        if (currentBalanceP == payoutMileStone1) {
            redeemableEther[msg.sender] += mileStoneReward;
        }
        else if (currentBalanceP == payoutMileStone2) {
            redeemableEther[msg.sender] += finalReward;
        }
        depositWei += msg.value;
        return;
        
    }
    
    function claimRewardP() public {
        
        require(depositWei == finalMileStone);
        
        redeemableEther[msg.sender] = 0;
        
        msg.sender.transfer(finalReward);
    }
}

// FibonacciLib.

contract  Fibonaccililb {
    
    uint public start;
    uint public calculatedFibNumber;
    
    
    function setStart(uint _start) public {
        start = _start;
    }
    function setFibonacci(uint n) public {
        calculatedFibNumber = fibonacci(n);
    }    
    
    function fibonacci(uint n) internal returns (uint) {
        if (n == 0) return start;
        else if (n == 1) return start + 1;
        else return fibonacci(n -1) + fibonacci(n - 2);
    }
}

// Lets now consider a contract that use this lib 

//contract FibBal {
  //  address public fi