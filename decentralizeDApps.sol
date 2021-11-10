/**  DApps: A Basic DApp Example:
    Auction DApp: Componets:
        # smart contract implementing ERC 721 non-fungible 'deed' tokens (DeepRepository)
        
        # A smart contract implementing an auction (AuctoinRepository) to sell the deeds

        # A web frontend using the Vue/Vuetify JAvaScript framework

        # The web3.js library to connect to Eth chains (via MetaMask or other clients)

        # A Swarm clietnm to store resources such as images

        # A whisper client, to create per-auction chat rooms for all particioants.

    */

pragma solidity  0.7.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';



/** 
    * @title Repository of ERC721 Deeds
    * This contract contains the list of deeds registered by users.
    * This is a demo tm show how token (deeds) can be minted and added
    * to the repository>
*/

contract DeedRepository is ERC721Token {

    /**
    * @dav Created A DeedRepository with a na,e and symbol

    * @param_name string represents the name of the repository 

    * @param _tokenId uint256 represents a specific deed,
    */
    function DeedRepository(string _name, string _symbol)
        public ERC721Token(_name, symbol){}

    /**
    * @dev Public fucntion to register a new deed
    * @dev Call the ERC721Token minter
    * @param _tokenId uint256 represents a specific deed
    * @param _uri string containg metadata/uri
    */

    function registerDeed(uint256 _tokenId, string _uri) public {
        _mint(msg.sender, _tokenId);
        addDeedMetadata(_tokenId, uri);
        emit DeedRegistered(msg.sender, _tokenId);
    }
    /**
    * @dev Public fucntion to add metadata to a deed
    * @param _tokenid represents a specific deed 
    * @param _uri text which describes the characteristics of a given deed 
    @ @return whether the deed metadata was added to the repository.
    */
    function addDeedMetadata(uint256 _tokenId, string _uri) public returns(bool) {
        _setTokenURI(_tokenId, _uri);
        return true;
    }

    /**
    * @dev Event is triggered if deed /token is registered 
    * @param _by address of ht redistrar
    * @param tokenId uint represents a specific deed,
    */
    event DeedRegistered(address _by, uint256 _tokenId);
}

// AuctionRepository.sol: Themain Auction Dapp smart contract 

contract AuctionRepository {

    // Array with all auctions

    Auction[] public auctions;

    // Mapping from auction index to user bids

    mapping(uint256 => Bid[]) public auctionBids;
    
    mapping(address => uint[]) public auctionOwner;

    // Bid struct to hold bidder and amount 

    struct Bid {
        address from;
        uint256 amount;
    }

    // Action struct which holds all the required info

    struct Auction {
        string name;
        uint256 blockDeadline;
        uint256 startPrice;
        string metadata;
        uint256 deedId;
        address deedRepositoryAddress;
        address owner;
        bool active;
        bool finalized; 
    }


    // The AuctionRepository contract manages all auctions with the following functions

    getCount()
    getBindsCount(uint _auctionId)
    getAuctionsOf(address _owner)
    getCurrentBid(uint _aucitonId)
    getAuctionsCountOfOwner(address _owner)
    getAuctionById(uint _auctionId)
    createAuction(address _deedRepositoryAddress, uint256 _deedId, string _auctionTitle, string _metadata, uint256 _startPrice)
    approveAndTransfer(address _from, address _to, address _deedRepositoryAddress, uint256 _deedid)
    cancelAuction(uint _auctionId)
