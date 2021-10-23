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

// 
