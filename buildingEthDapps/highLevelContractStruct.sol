pragma solidity >=0.4.0 <0.8.0;

contract AuthorizedToken{

    enum UserType {TokenHolder, Admin, Owner}

    struct AccountInfo {
        address account;
        string firstName;
        string lastName;
        UserType userType;
    }

    mapping (address => uint256)
        public tokenBalance;
    
    mapping (address => AccountInfo)
        public registeredAccount;

    mapping (address => bool)
        public frozenAccount;

    address public owner;

    uint256 public constant maxTranferLimit = 15000;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event FrozAccount(address target, bool frozen);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(uint256 _initialSupply) public {
        owner = msg.sender;

        mintToken(owner, _initialSupply);
    }

    function transfer(address _to, uint256 _amount) public {
        require(checkLimit(_amount));

        emit Transfer(msg.sender, _to, _amount);
    }
    
    function registerAccount(address account, string firstName, string lastName, bool isAdmin) public onlyOwner {

    }
    
    function checkLimit(uint256 _amount) private returns (bool) {
    if (_amount < maxTranferLimit)
    return true;
    return false;
    }

    function validateAccount (address _account) internal returns (bool) {
        if (frozenAccount[_account] && tokenBalance[_account] > 0)
        return true;
        return false;
    }

    function mintToken(address _recipient, uint256 _mintedAmount) onlyOwner public {
        tokenBalance[_recipient] += _mintedAmount;
        emit Transfer(owner, _recipient, _mintedAmount);
    }

    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        emit FrozAccount(target, freeze);
    }
}

contract IntConversions {
    int256 bigNumber = 150000000000;
    int32 mediumNegativeNumber = -450000;
    uint16 smallPostitiveNumber = 15678;

    int16 newSmallNumber = bigNumber;

    uint64 newMediumPositiveNumber = mediumNegativeNumber;

    uint32 public newMediumNumber = smallPostitiveNumber;

    uint256 public newBigNumber = mediumNegativeNumber;
}

// ETH Transfer example using transfer():
/* destinationAddress.transfer(10);

ENUMS: An enum is a custom data type including a set of na,ed values for excpaled 


enum InvestmentLevel {High, Medium, Low}

InvestmentLevel level = InvestmentLevel.Medium;

*/

// Reference types with location declared implicitly or explicitly
contract ReferenceTypeSample {
    uint[] storageArray;

    function f(uint[] memory fArray) public {}
    function g(uint[] storage gArray) internal {}
    function h(uint[] memory hArray) internal {}

    // Static Arrays: we must specify size of a static array in it declaratiion.

    function staticArr() internal {
        int32[5] memory fixedSlots;
        fixedSlots[0] = 5;
    }

    // to allocate a static array and set it inlilne
    function  inlineArr() internal {
        int32[5] memory fixedSlots = [int32(5), 9, 1, 3, 4];
    }

    // Dynamic Arrays dont need specific size in decliration 

    function dynamicArr() internal {
        int32[] memory unlimitedSlots;
    

        unlimitedSlots.push(6);

        unlimitedSlots.push(4);
    }
}

