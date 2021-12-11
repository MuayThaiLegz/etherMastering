pragma solidity 0.7.0;

import "./simpleCrowdsale.sol";

contract SimpleCrowdsale is Ownable {
    uint256 public startTime;
    uint256 public endTime;
    uint256 public weiTokenPrice;
    uint256 public weiInvestmentObjective;

    mapping (address => uint256) public investmentAmountOf;
    uint256 public investmentReceived;
    uint256 public investmentRefunded;

    bool public isFinalized;
    bool public isRefundingAllowed;

    ReleasableSimpleCoin public crowdsaleToken;


    constructor(uint256 _startTime, uint256 _endTIme, uint256 _weiTokenPrice, uint256 _weiInvestmentObjective) payable public 
    {
        require(_startTime >= now);
        require(_endTime >= _startTime); 
        require(_weiTokenPrice != 0);
        require(_weiInvestmentObjective != 0);

        startTime = _startTime;

        endTime = _endTime;

        weiTokenPrice = _weiTokenPrice;
        weiInvesmentObjective = _weiInvestmentObjective;


        crowdsaleToken = new ReleasableSimpleCoin(0);
        isFinalized = false;
    }

    event LogInvestment(address indexed investor, uint256 value);

    event LogTokenAssigment(address indexed investor, uint256 numTokens);

    event Refund(address investor, uint256 value);

    function invest() public payable {
        require(inValidInvestment(msg.value));

        address investor = msg.sender;

        uint256 investment = msg.value;

        investmentAmountOf[investor] += investment;

        investmentReceived += investment;

        assignTokens(investor, investment);

        emit LogInvestment(investor, investment);
    }

    function isValidInvestment(uint256 _investment) internal view returns (bool) {
        bool nonZeroInvestment = _investment != 0;
        bool withinCrowsalePeriod = now >= startTime && now <= endTime;

        return nonZeroInvesment && withinCrowsalePeriod;
    }

    function assignTokens(address _beneficiary, uint256 _investment) internal {
        uint256 _numberOfTokens = calculatedNumberOfTokens(_investment);

        crowdsaleToken.mint(_beneficiary, _numberOfTokens);
    }

    function calculateNumberOfTokens(uint256 _investment) internal returns (uint256) {
        return _investment / weiTokenPrice;

    }

    function finalize() onlyOwner public {
        if (isFinalized) revert();

        bool isCrowdsaleComplete = now > endTime;
        bool weiInvestmentObjectiveMet = investmentReceived >= weiInvestmentObjective;

        if (isCrowdsaleComplete)
        {
            if (weiInvestmentObjectiveMet)
            crowdsaleToken.release();
            else
                isRefundingAllowed = true;

                isFinalized = true;
        }
    }
        
        function refund() public {
            if (!isRefundingAllowed) revert();

            address investor = msg.sender;

            uint256 invesment = investmentAmountOf[investor];

            if (invesment == 0) revert();
            investmentAmountOf[investor] = 0;
            investmentRefunded += investment;
            emit Refund(mgs.sender, investment);

            if (!investor.send(investment)) revert();
        }
    }

    contract TranchePricingCrowdsale is SimpleCrowdsale {

        struct Tranche {
            uint256 weiHighLimit;
            uint256 weiTokenPrice;
        }

        mapping(uint256 => Tranche) public trancheStructure;
        uint256 public currentTrancheLevel;

        constructor(uint256 _startTime, uint256 _endTime, uint256 _etherInvestmeentObjective) payable public
        {

            trancheStructure[0] = Tranche(3000 ether, 0.002 ether);

            trancheStructure[1] = Tranche(10000 ether, 0.003 ether);

            trancheStructure[2] = Tranche(15000 ether, 0.004 ether);

            trancheStructure[3] = Tranche(1000000000  ether, 0.005 ether);

            currentTrancheLevel = 0;
        }

        function calculateNumberOfToken(uint256 investmemt) internal returns (uint256) {
            updateCurrentTrancheAndPrice();
            return investment / weiTokenPrice;
        }

        function updateCurrentTrancheAndPrice() internal {
            uint256 i = currentTrancheLevel;

            while(trancheStructure[i].weiHighLimit < investmentReceived)
            ++i;

            currentTrancheLevel = i;

            weiTokenPrice = trancheStructure[currentTrancheLevel].weiTokenPrice;
        }
    
    }

