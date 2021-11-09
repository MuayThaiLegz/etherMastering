/* Oracles  exaples of data  provided include 
    * Random numbers/entropy from physical sources such as quantum/thermal processes e.g.,
        to fairly select a winner in a lottery smart contract 
    
    * Parametric triggers indexed to natural hazards: e.g., triggering of catastrophebond smart contracts,
        such as Richter scale measurements for an erathquake bond.
    
    * Exchane rate data: e.g., for accurate pagging of cryptocurrencies to fiat currency .

    * Capital markerts data- pricing baskets of tokinzed assets/securities # NFT ETF????????

    * Sporting events: for prediction market resolution and fantasy sports contracts

    * Geolocation data: as used in supply chain tracking

    * Damage verification: for insurance contracts

# Oracle Design Patterns - All oracles provide a few ket fucntions, by definition. These incllude the ability to:
    * COllect data from an off-chain cosurce; * Transfer the data on-chain with a signed maessage.
     * Make data avaliable by putting it in a smart contract's strorage.


Once data is available in a smart contract's storage,
it can be accessed by other smart contracts via calls tha invoke a 'retrieve' function of the oracle's smart contract.
*/

/* public class SampleContractCryplet : Cryplet
    {   
        public SampleContractCryplet(Guid id, Duid bindingId, string name, 
            string address, IContainerServices hostContainer, bool contract)
            : base(id, bindingId, name, address, hostContainer, contract)
    {   
        MessageApi = new CypletMessageApi(GetType().FullName,
            new SampleContractConstructor())
*/

// Using Oraclize to update the ETH/USD exchange rate from an external source
/* 
    ETH/USD price ticker leveraging CryptoCompare API

    This contracat keeps in storage an updated ETH/USD price,
    which is updated everey 10 minutes.
    */
pragma solidity ^0.5.0;

import 'https://github.com/pkdcryptos/oraclize-ethereum-api/blob/master/oraclizeAPI_0.5.sol';

// 'oraclize_' prepended methods indicate inheritance from 'usingOraclize'

contract EthUsdPriceTickers is usingOraclize {

  uint public ethUsd;

  event  newOraclizeQuery(string description);
  event newCallbackResult(string result);

  function EthUsdPriceTicker() payable internal {
    // signals TLSN proof generation and storeage on IPFS
    oraclize_setProof(proof_TLSNotary | proofStorage_IPFS);
    
    // requests quert 
    queryTicker();
}

   function __callback(bytes32 _queryId, string _result, bytes _proof) public {
    if (msg.sender != oraclize_cbAddress()) revert;
    newCallbackResult(_result);
    
    /* 
    * Parse the result string into an unsigned interger for on-chain use.
    * Uses inherited 'parseInt' helper from 'usingOraclize', allowing for 
    * a string reslut such as '123.45' to be converted to uint 12345.
    */
    ethUsd = parseInt(_result,2);
    
    // called form callback since we;re polling the price
    queryTicker();
}

    function queryTicker() public payable {
    if (oraclize_getPrice("URL") > this.balance) {
        newOraclizeQuery('Oraclize query was NOT sent,  please add some ETH to cover query fee');
    } else {
        newOraclizeQuery('Oraclize query was sent, standing by for the answer...');
    }
        
        // query params are (delay in sseconds, datasorce type, 
        // datasource argument)
        // specifies JSONPath, to fetch specific of JSON API result
        oraclize_(60 * 10, 'URL', 
        'json(https://min-api.cryptocompare.com/data/price?\
        fsym=ETH&tsyms=USD,EUR,GBP).USD');
        
    }
}


// Example Contract calling the BlockONeIq service for markert data

contract Oracle {
    
    uint256 public divisor;
    function initRequest(
        uint256 queryType, function(uint256) external onSuccess //,
        function(uint256) external onSuccess //,
        function(uint256) external onFailure) public returns (uint256 id);
        function addArgumetnToRequestUint(uint256 id, bytes32 name, uint256 arg) public;
        function addArgumetnToRequestString(uint256 id, bytes name, bytes32 arg)
            public;
        function executeRequest(uint256 id) public;
        function getResponseUint(uint256 id, bytes32 name) public constant
            returns(uint256);
        function getResponseString(uint256 id, bytes32 name) public constant
            returns(bytes32);
            
        function getResponseError(uint256 id) public constant returns(bytes32);
        function deleteResponse(uint256 id) public constant;
}

contract OracleB1IQClient {
    Oracle private oracle;
    
    event LogError(bytes32 description);
    
    function OracleB1IQclient(address addr) public payable {
        oracle = Oracle(addr);
        getIntraday('IBM', now);
    }
    
    function getIntraday(bytes32 ric, uint256 timestanp) public {
        uint256 id = oracle.initRequest(0, this.handleSuccess, this.handleFailure);
        oracle.addArgumetnToRequestString(id 'symbol', ric);
        oracle.addArgumetnToRequestUint(id, 'timestamp', timestamp);
        oracle.executeRequest(id);
    }
    
    
    function handleSuccess(uint256 id) public {
        assert(msg.sender == address(oracle));
        bytes32 ric = oracle.getResponseString(id, 'symbol');
        uint256 open = oracle.getResponseUint(id, 'open');
        uint256 high = oracle.getResponseUint(id, 'high');
        uint256 low = oracle.getResponseUint(id, 'low');
        uint256 close = oracle.getResponseUint(id, 'close');
        uint256 bid = oracle.getResponseUint(id, 'bid');
        uint256 ask = oracle.getResponseUint(id, 'ask');
        uint256 timestamp = oracle.getResponseUint(id, 'timestamp');
        oracle.deleteResponse(id);
        // Do something with the price datas
    }

    function handleFailure(uint256 id) public {
        assert(msg.sender == address(oracle));
        bytes32 error = oracle.getResponseError(id);
        oracle.deleteResponse(id);
        emit logErro(error);
    }
        
        
        
        
        
            
}
