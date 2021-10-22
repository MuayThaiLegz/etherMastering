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


