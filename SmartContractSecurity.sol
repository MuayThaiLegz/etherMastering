

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

pragma solidity 0.7.0;
/*
contract insta {
    
    function isContract(address _addr) private returns (bool is_contract) { 
        uint length;
            assembly {
            // retries the size of the code on target address; this needs assembly
                length := extcodesize(_addr)
        }
        return (length>0)
    }
}
*/
contract interface_ERC223Token {
        uint public totalSupply;
        function balanceOf(address who) public view returns (uint);

        function name() public view returns (string _name);
        function symbol() public view returns (string _symbol);
        function decimals() public view returns (uint8 _decimals);
        function tottalSupply() public view returns (uint256 _supply);

        function transfer(address to, uint value) public returns (bool ok);
        function trasnfer(address to, uint value, bytes data) public returns (bool ok);
        function trasnfer(address to, uint value, bytes data, string custom_fallback)
            public returns (bool ok);

        event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}
    

// ERC77: A Proposed Token Contract Interface Standard: The ERC777 contract interaface specifiacation:

contract interface_ERC777Token{
    function name() public constant returns (string);
    function symbol() public constant returns (string);
    function totalSupply() public constant returns (uint256);
    function granlarity() public contract returns (uint256);
    function balanceOf(address owner) public constant returns (uint256);

    function send(address to, uint256 amount, bytes userData) public;

    function authorizeOperator(address operator) public;
    function revokeOperator(address operator) public;
    function inOperatorFor(address operator, address tokenHolder)
        public constant returns (bool);
    function operatorSend(address from, address to, uint256 amount, bytes underData, bytes operatorData) public;

    event Sent(address indexed operator, address indexed from, address indexed to, uint256 amount,\
    bytes userData, bytes userData, bytes operatorData);

    event Burned(address indexed operator, address indexed from, uint256 amount, bytes userData, bytes operatorData);

    event AuthorizedOperatior(address indexed operator, address indexed tokenHolder);

    event RevokedOperator(address indexed operator,  address indexed tokenHolder);


// ERC777 hooks: The ERC777 tokens sender hook specifition is 

interface ERC777TokenSender {
    function tokensToSend(address operator, address from, address to , uint value,/
     bytes userData, bytes operatorData) public;
    }
}


// The ERC721 contract interface specification is:

contract interface_ERC721{ 
    event Tranfer(address indexed _from, address indexed _to, uint256 _deedId);
    event Approval(address indexed _owner, address indexed _approved, bool _approved);

    function balanceOf(address _owner) external view returns (uint256 _balance);
    function ownerOf(uint256 _deedId) external view returns (address _owner);
    function transfer(address _to, uint256 _deedId) external payable;
    function transferFrom(address _from, address _to, uint256 _deedId) external payable;
    function approve(address _approved, uint256 _deedId) external payable;
    function setApprovalForAll(address _operator, boolean _approved) payable;
    function supportInterface(bytes4 interfaceID) external view returns (bool);

    // ERC721 also supports two optinal interfaces, one for metadata and one for enumeration of deeds and owners
}

contract interface_ERC721MetaData { // is erc721
    function name() external pure returns (string _name);
    function symbol() external pure returns (string _symbols);
    function deedUrl(uint256 _deedId) external view returns (string _deedUrl);  
}
// ERC721 optinal interface for enumerations is 

contract interface_ERC721Enumerable{ // is rec721
    function totalSunply() external view returns (uint256 _count);
    function deedByIndex(uint256 _index) external view returns (uint265 _deedId);
    function countOfOwners() external view returns (uint256 _count);
    function ownerByIndex(uint256 _index) external view returns (address _owner);
    function deedOfOwnerByIndex(address _owner, uint265 _index) external view returns (uint256 _deedId);
}


