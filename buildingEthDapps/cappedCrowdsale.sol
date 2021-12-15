pragma solidity 0.7.0;

import 'introContract.sol/simpleCrowdsale.sol';

contract CappedCrowdsale is SimpleCrowdsale {
    uint256 fundingCap;

    constructor(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _weiTokenPrice, 
        uint256 _etherInvestmentObjective, 
        uint256 _fundingcap) SimpleCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective) payable public {
            
            require(_fundingcap > 0);
            fundingcamp = _fundingcap;

        }
        
        function isValidInvestment(uint256 _investment) internal view returns (bool){
            bool nonZeroInvesment = _investment != 0;
            bool withinCrowsalePeriod = now >= startTime && endTime;

            bool isInvestmentBelowCap = investmentReceived + _investment < fundingCap;

            return nonZeroInvesment && withinCrowsalePeriod && inInvestmentBelowCap;

        }
}

// following this change CappedCrowdsale no longer needs to override isValidInvestment, but only isFUllInvestmentWithinLimit()
contract CappedCrowdsale is SimpleCrowdsale {
    uint256 fundingCap;

    function CappedCrowdsale(
        uint256 _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective, uint256 _fundingCap
)   SimpleCrowdsale(_startTime, _endTime, _weiTokenPricem, _etherInvestmentObjective) payable public {

    require(fundingCap > 0);
    fundingCap = _fundingCap;
}

    function isFullInvestmentWithinLimit(uint256 _investment) internal view returns (bool) {
    bool check = investmentReceived + _investment < fundingCap;
    return check;
    }
}


// Capped funding and tranche-based pricing 

contract CappedTranchePricingCrowdsale is TranchePricingCrowdsale {
    uint256 fundingCap;

    constructor(uint256 _startTime, uint256 _endTime, uint256 _etherInvestmentObjective, uint256 _fundingCap)
    TranchePricingCrowdsale(_startTime, _endTime, _etherInvestmentObjective) payable public 
    {
        require(_fundindCap > 0);
        fundingCap = _fundingCap;
    }
    
    function isFullInvestmentWithinLimit(uint256 _investment) internal view returns (bool) {
         bool check = investmentReceived = _investment < fundingCap;
         return check;
    }
}


/*

A funding strategy base contract for all possible funding limit strategies. 
    # CappedFundingStrategy-- Crowdsale with funding capped by fundingCap limit
    # UnlimitedFundingStrategy-- Crowdsale with unlimited (uncapped) funding
*/ 

contract FundingLimtiStrategy{
    function isPullingInvestmentWithinLimit(uint256 _investment) public view returns (bool);  
}

// implementation for a capped crowdsale from FundingLimtiStrategy

contract CappedFundingStrategy is FundingLimtiStrategy {
    uint256 fundingCap;

    constructor(uint256 _fundingCap) public {
        require(_fundingCap > 0);
        fundingCap = _fundingCap;
    }

    function isFullInvestmentWithinLimit(
        uint256 _investment,
        uint256 _fullInvestmentReceived)
        public view returns (bool) {

        bool check = _fullInvestmentReceived + _investment < fundingCap;
        return check; 
    }
} 

// implementation for a unlimited funding crowdsale from FundingLimtiStrategy

contract UnlimitedFundingStrategy is FundingLimtiStrategy {
    function isFullInvestmentWithinLimit (
        uint256 _invesment,
        uint256 _fullInvestmentReceived) public view returns (bool) { return true; }  
    }


contract UnlimitedFixedPricingCrowdsale is FixedPricingCrowdsale {

    constructor(uint _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective)
    FixedPricingCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective)
    payable public {
    }

    function createFundingLimitStrategy() internal returns (FundingLimtiStrategy) {

        return new UnlimitedFundingStrategy();
    }
}

contract CappedFixedPricingCrowdsale is FixedPricingCrowdsale {
    
    constructor(uint256 _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective)
    FixedPricingCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective) payable public {
    }

    function createFundingLimitStrategy() internal returns (FundingLimtiStrategy) {


        return new UnlimitedFundingStrategy();
    }
}

contract CappedFixedPricingCrowdsale is FixedPricingCorwdsale {
    
    constructor(uint256 _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective)

    FixedPricingCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective) payable public {
    }

    function createFundingLimitStrategy() internal returns (FundingLimitStrategy) {

        return new CappedFundingStrategy(10000);
    }
}
    
contract UnlimitedTranchePricingCrowdsale is TranchePricingCrowdsale {

    constructor(uint256 _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective)
    TranchePricingCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective) payable public {
    }

    function createFundingLimitStrategy() internal returns (FundingLimitStrategy) {

        return new UnlimitedFundingStrategy();
 
    }
}

contract CappedTranchePricingCrowdsale is TranchePricingCrowdsale {

    constructor(uint256 _startTime, uint256 _endTime, uint256 _weiTokenPrice, uint256 _etherInvestmentObjective)
    TranchePricingCrowdsale(_startTime, _endTime, _weiTokenPrice, _etherInvestmentObjective) payable public {
    }

    function createFundingLimitStrategy() internal returns (FundingLimitStrategy) {
    
        return new CappedFundingStrategy(10000);
    
 
    }
}

/* 
Setting functional requirements with interfaces.
The syntax construct that defines the minimum set of functions the token contract should support is called an interface.
The token interface that ContractName would look like this:
*/

interface ReleaseableToken {
    function mint(address _beneficiary, uint256 _numberOfTokens) external;
    function release() external;
    function transfer(address _to, uint256 _amount) external;
}

// Referencing a contract through an interface 
// You can define a contract that implements this interface  by inheriting from it. Can also create other implementations:

// Making SimpleCoin ERC20 compliant 

