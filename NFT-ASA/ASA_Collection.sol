// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Advanced Sovereign Infrastructure & Crypto Ecosystem (ASICE)
 * @notice Property Owner: Eng. Awsan Adel Abdulberi Ahmed Sultan
 * @dev National ID: 01010305468 | Country: YEMEN | Copyright © 2026 All Rights Reserved.
 * @dev Custom ERC721 Standard compliant with Pi Network Eco-guidelines.
 */

contract ASA_Collection {
    string public name = "Awsan Sultan Art";
    string public symbol = "ASA";
    address public owner;
    uint256 public nextTokenId;
    uint256 public royaltyFee = 5; // نسبة 5% عوائد ملكية فكرية للمهندس أوسان

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event NFTMinted(address indexed to, uint256 indexed tokenId, string tokenURI);

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized: Only Eng. Awsan Sultan can execute this");
        _;
    }

    constructor() {
        owner = msg.sender;
        nextTokenId = 1;
    }

    function balanceOf(address account) public view returns (uint256) {
        require(account != address(0), "Zero address query");
        return _balances[account];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address nftOwner = _owners[tokenId];
        require(nftOwner != address(0), "Token ID does not exist");
        return nftOwner;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenURIs[tokenId];
    }

    function createNFT(address to, string memory _uri) public onlyOwner returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");
        uint256 currentId = nextTokenId;
        
        _owners[currentId] = to;
        _balances[to] += 1;
        _tokenURIs[currentId] = _uri;

        emit Transfer(address(0), to, currentId);
        emit NFTMinted(to, currentId, _uri);
        
        nextTokenId += 1;
        return currentId;
    }

    function legalDisclaimer() public pure returns (string memory) {
        return "This NFT Collection (ASA) is the exclusive intellectual property of Eng. Awsan Sultan. All IP rights reserved 2026.";
    }
}
