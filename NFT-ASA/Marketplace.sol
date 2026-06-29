// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ASICE Sovereign NFT Marketplace
 * @notice Platform Founder: Eng. Awsan Adel Abdulberi Ahmed Sultan
 * @dev National ID: 01010305468 | Country: YEMEN | Copyright © 2026 All Rights Reserved.
 * @dev Decentralized NFT Trading Engine built for ASA Ecosystem & Pi Browser Integration.
 */

interface IASA_Collection {
    function ownerOf(uint256 tokenId) external view returns (address);
    function balanceOf(address account) external view returns (uint256);
}

contract ASAMarketplace {
    address public founder;
    uint256 public platformFeePercent = 25; // رسوم تداول 2.5% لدعم صندوق التطوير (مضروبة بـ 10 لتجنب الفواصل)

    struct Listing {
        address seller;
        uint256 price;
        bool isActive;
    }

    // ربط مصفوفة الإدراجات: معرف الـ NFT يشير إلى تفاصيل البيع
    mapping(uint256 => Listing) public listings;

    event NFTListed(uint256 indexed tokenId, address indexed seller, uint256 price);
    event NFTSold(uint256 indexed tokenId, address indexed buyer, address indexed seller, uint256 price);
    event ListingCancelled(uint256 indexed tokenId, address indexed seller);

    modifier onlyFounder() {
        require(msg.sender == founder, "Unauthorized: Only Eng. Awsan Sultan can execute this");
        _;
    }

    constructor() {
        founder = msg.sender;
    }

    function listNFT(uint256 tokenId, uint256 price) public {
        require(price > 0, "Price must be higher than zero");
        
        listings[tokenId] = Listing({
            seller: msg.sender,
            price: price,
            isActive: true
        });

        emit NFTListed(tokenId, msg.sender, price);
    }

    function buyNFT(uint256 tokenId) public payable {
        Listing storage listing = listings[tokenId];
        require(listing.isActive, "NFT is not listed for sale");
        require(msg.value >= listing.price, "Insufficient funds submitted");

        address seller = listing.seller;
        uint256 salePrice = listing.price;

        // حساب رسوم المنصة الحصرية (2.5%) لصندوق تطوير المهندس أوسان
        uint256 platformFee = (salePrice * platformFeePercent) / 1000;
        uint256 sellerProceeds = salePrice - platformFee;

        // إغلاق الإدراج برمجياً لمنع الاختراقات المتكررة (Reentrancy Protection)
        listing.isActive = false;

        // تحويل المبالغ بأمان
        payable(founder).transfer(platformFee);
        payable(seller).transfer(sellerProceeds);

        emit NFTSold(tokenId, msg.sender, seller, salePrice);
    }

    function cancelListing(uint256 tokenId) public {
        Listing storage listing = listings[tokenId];
        require(listing.isActive, "Listing is not active");
        require(listing.seller == msg.sender, "You are not the seller");

        listing.isActive = false;
        emit ListingCancelled(tokenId, msg.sender);
    }

    function getPlatformFees() public pure returns (string memory) {
        return "Standard 2.5% fee goes directly to Eng. Awsan Sultan Development Fund.";
    }
}
