const { networkInterfaces } = require("os");
const { compileFunction } = require("vm");

web3.eth.getGasPrice(console.log);

// Transaction Recipient

// Transaction Value and Data 
src = web.eth.accounts[0];
dst = web3.eth.accounts[1];

// Our first transaction contains only a value (payment) and no data payload

web.sendTransaction({from: src, to: dst, value: web3.toWei(0.01, 'ether'), data: ''});

// The next example specifies both a value and a payload

web3.eth.sendTransaction({from: src, to: dst, value: web3.toWei(0.01, 'ether'), data:'0x1234'});

// The next transaction includes a data payload but specifies a value of zero:

web3.eth.sendTransaction({from: src, to: dst, value: 0, data: '0x1234'});

// Finally, the last transaction includes neither a value to send not a data payload

web3.eth.sendTransaction({from: src, to: dst, value: 0, data: ''});

web3.sha3("withdraw(uint256)");

// we want to withdraw 0.01 ether. Let's encode that ot a hex-serialized big-endian 
// unsingned 256-bit interger, denominated in wei:

withdraw_amount = web.toWei(0.01, 'ether');

withdraw_amount_hex = web3.toHex(withdraw_amount);


// Transactioon context
// The tx object provides a means of accessing transsaction-realted information

tx.gasPrice
    // The gas price in the calling transaction.

tx.origin
    // The address of the originating EOA for this transaction. WARNING; unsafe!

// Block context 

    // The block object contains information about the current block

block.blockhash(blockNumber)
    // The block hash of the specified block number, up to 256 blocks in the past.
    // Doprecates and repalced with the blockhash function

block.coinbase
    // The address of the recipient of the current block's fees and block reward.

block.difficulty
    // The difficulty (proof of work) of the current block

block.gaslimit
    // The max amount of gas that can be spent across all transacntions included in the cuurent block.

block.blockNumber
    // The current block number (blockchain height)

block.timestamp
    // The timestamp placed in the current blocl by the miner ( number of seconds since the Unix epoch)

// Address Object 
// Any address, either passed as an inout or cast from a contract pbject, has a number of sttribuytes and methods

address.balance 
    // The balance of the address, in wei, EX current contract balance is address(this).balance

address.tranfer(amount) 
    // Tranfoers the amount (in wei) to this address, throwing an exception on any error. We used this fucntion in our Faucet EX

address.send(amount)
    // Similiar to tranfer, only instead of trhowing an eception, it returns false on error.
        // WARNING always check the return value of send.

address.call(payload)
    // Low-level call futnion-0 can construct an arbitrary message call with a data payload. Retuns false on error. Unsafe.

address.delagatecall()
    // Low-level Delegatecall fucntion, like callcode(...) but with the full msg context senn by the curr contract.
        // Returns false on erroe WARNING: advanced use only

// Built-in functions
// Other fucntions worth noting are:

addmod, mulmod
 // # For modulo addition and multiplication. EX addmod(x,y,k) calculates (x + y) % k

 ecrecoer
    // Recovers the address used to sign a message from the sinature

selfdestruct(recipient_address)
    // Deletes the current contract, sending any remaingn  eth in the account to the recipients address 

this
    // The address of the currently executing contract account

// Truffle development environment and capture the events, to see how it looks

truffle(develop)> migrate

truffle(develop)> web3.eth.accounts[0]

truffle(develop)> caller.address

truffle(develop)> calledContract.address

truffle(develop)> calledLibrary.address

truffle(develop)> caller.deployed().then( i => {callerDeployed = i })

truffle(develop)> callerDeployed.make_calls(calledContract.address).then(res => {res.logs.forEach( log => { console.log(log,args) })})

var contract = web.eth.contract(abi).at(address);

var getEstimate = contract.myAweSomeMethod.estimateGAs(arg1, arg2,
    {from : account});

// Obtain the gas price form the network you can use

var gasPrice = web3.GasPrice();

// And from there you can estimate gas cost;

var gasCostInEth = web3.fromWei((gasEstimate * gasPrice), 'ether');

// Apply our gas estimation function to estimating the gas cost of faucet

var FaucetContract = artifacts.require('./faucet.sol');

FaucetContract.web3.eth.gasGasPrice(function(error, result) {
    var gasPrice = Number(result);
    console.log('Gas Price is' + gasPrice + ' wei'), // '1000000000000

    // Get the contract instance 
    FaucetContract.deployed().then(function(FaucetContractInstance) {
        // Use the keyword 'estimateGas' after the fcuntion name to get the gas 
        // estimatin for this particular function (aprove)
        FaucetContractInstance.send(web3.toWei(1, 'ether'));
return FaucetContractInstance.withdraw.estimateGAs(web3.toWei(0.1, 'ether'));
}).then(function(result) {
    var gas = Number(result);

    console.log('gas estimation =' + gas + " units");
    console.log('gas cost estimation = ' + (gas * gasPrice) + ' wei');
    console.log('gas cost estimation = ' + FaucetContract.web3.fromWei((gas * gasPrice), 'ether') + ' ether');
    });
});

var METoken = artifacts.require('METoken');

module.exports = function(deployer) {
    // Deploy the METoken contract as our onlu task
    deployer.deploy(METoken);
};
/*
truffle(ganache) > METoken
{ [Function: TruffleContract]
_static_methods:
//[....],

currentProvier:
HttpProvider {
    host: 'http://localhost:7545',
    timeout: 0,
    user: undefined,
    password: undefined,
    headers: undefined,
    send: [Function],
    sendAsync: [Function],
    _alreadyWrapped: true },
network_id: '5777' }
*/

truffle(ganache) > METoken.address

// To interact with the deployed contract, we have to use an asynchronous call
// in the form of a JaveScript 'promise', We use the deployerd fucntion to get the contract instance and them

truffle(ganache)> METoken.deployed().then(instance => instance.totalSupply())

// Let's use the accounts accounts created by ganache to check our METoken balance abd send eth

truffle(ganache)> let accounts

truffle(ganache)> web3.eth.getAccounts((err, res) => { accounts = res })

truffle(ganache)> accounts[0]

/* The accounts list now contrain all the accounts created by ganache, and account[0]
 is ther account that deployed the METoken contract. It should have a balance of METoken
 bacause out METoken constuctor gives the entire token supply to the address that created it.
*/
truffle(ganache)> METoken.deployed().then(instance =>
                    { instance.balanceOf(accounts[0]).then(console.log) })

truffle(ganache)> BigNumber { s: 1, e: 9, c: [2100000000 ] } 

// Transfer 1000.00 METoken form account[0] to account[1],
// by calling the contract's transfer function:

truffle(ganache)> METoken.deployed().then(instance =>
                    { instance.tranfer(accounts[1], 100000) } )

truffle(ganache)> METoken.deployed().then(instance => 
    {instance.balanceOF(accounts[0]).then(console.log) })

truffle(ganache)> BigNumber {s: 1, e: 9, c: [2099900000 ] }

truffle(ganache)> METoken.deployed().then(instance =>
                  { instance.balanceOf(accounts[1]).then(console.log) })

truffle(ganache)> BigNumber { s: 1, e: 5, c: [; 100000] }

// We'll also add a migration, to deploy Faucet separately form METoken

var Faucet = artifacts.require('Faucet');

module.exports = function(deployer) {
    deployer.deploy(Faucet);
};

// Let;s compile and migrate contracts form the truffle console:
truffle console --network ganache

truffle(ganache)> compile

truffle(ganache)> migrate

// Great. Now let's send some MET to the faucet contract:

truffle(ganache)> METoken.deployed().then(instance =>
    { instance.tranfer(Faucet.address, 100000) })

truffle(ganache)> METoken.deployed().then(instance =>
    { instance.balanceOf(Faucet.address).then(console.log)})

truffle(ganache)> BigNumber { s: 1, e: 5, c: [ 100000] }
