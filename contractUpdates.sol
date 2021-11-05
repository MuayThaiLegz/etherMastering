pragma solidity 0.7.0;


//import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

// A faucet for erc20 token MET

contract METFaucet {
    StandardToken public METoken;
    address public METOwner;

    // METFauccet constructor, provide the address of METoken contract and 
    // The owner address we will be approved to transfer from

    function METFaucet(address _METoken, address _METower) public {

            // Initialize the METoken from the address provided
            METoken = StandardToken(_METoken);
            METOwner = _METoken;
    }
    function withdraw(uint withdraw_amount) public {

        // Limit withdraw amount to 10 MET
        require((withdraw_amount <= 1000);

                // Use the transferFrom function of METoken 
                METoken.transferFrom(METOwner, msg.sender, withdraw_amount);
    } 

    // REJECT any incoming ether
    function () public payable { revert(); }
}

StandardToken public METoken;
address public METower;

/* Since out faucet needs to be intialized with the correct addresses for metoken and metowner
we need to declare a custom constructor;*/
// METfaucet cosntructor - provide the eddredd of the METoken contract and
// the owner address we will be approved to transferform
function METFaucet(address _METoken, address _METOwner) public {

        // Initialize the METoken from the address provided
        METoken = StandardToken(_METoken);
        METower = _METOwner;
}

// We also change the withdraw function. Instead of transfer, METFaucet uses transferFrom

METoken.tranferFrom(METOwner, msg.sender, withdraw_amount);

/*

Now we need to modify the migration script to deply it. This migration scrpt will bw a bit more 
comples, as METFaucet depends on the eddress of METoken.\
Using a JavaScript promise to deply the to two contracats in sequence.

2deploy_contracts.js 

var METoken = artifacts.require('METoken')

var METFaucet = artifacts.require('METFaucet');

var owner = web3.eth.accounts[0];

module.exports = function(deployer) {

        //Deploy the METoken contract first
        deployer.deploy(METoken, {from: owner}).then(function()) {
                // Then deploy  METFaucet and pass the address of METoken and the 
                // address of the owner of all the MEt who will approve METfaucet
               return deployer.deploy(METFaucet, METoken.address, owner);
    }};
}

trufflre console --network ganache
truffle(ganache)> migrate
Using network 'ganache'

truffle(ganache)> METoken.deployed().then(instance =>
                    { instance.approve(METFaucet.address, 100000) })

truffle(ganache)> METoken.deployed().then(instance => 
                    { instance.balanceOf(web3.eth.accounts[1]).then(console.log) })

truffle(ganache)> BigNumber { s: 1, e: ), c: [0] }

truffle(ganache)> METoken.deployed().then(instance => 
                    { instance.withdraw(1000, {from:web3.eth.accounts[1]})}  )


truffle(ganache)> METoken.deployed().then(instance =>
                    { instance.balanceOF(web3.eth.accounts[])})

truffle(ganache)> BigNumber { s: 1, e: 3, c: [ 1000 ]}
