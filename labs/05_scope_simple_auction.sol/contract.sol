// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SimpleAuction{
    // 1. state variables are stored on-chain storage.
    address public owner; // address of auction owner
    uint256 public highestBid; // current highest bid;
    address public highestBidder; // current highest bidder
    bool public isAuctionEnded; // whether auction is ended

    // an auction record structure
    struct Bid{
        address bidder;
        uint256 amount;
        uint256 timestamp;
    }
    Bid[] public bidHistory; // the historical bid records of auction (stored in an array on-chain storage)

    // Assigned msg.sender to auction owner when deployed.
    constructor() {
        owner = msg.sender; // 
        highestBid = 0;
        highestBidder = address(0);
        isAuctionEnded = false;
    }


    // business function
    // 1. bid function: require the auction to be unfinished and higher than current highest bid.
    function bid() external payable {
        require(!isAuctionEnded, 'Auction already ended');
        require(msg.value > highestBid, 'Bid is too low');

        // 2. --- local variables - start ---
        address prevBidder = highestBidder;
        uint256 prevBid = highestBid;
        // ---local variables - end ---

        // update state variables
        highestBidder = msg.sender;
        highestBid = msg.value;

        // push this bid record into state variable bigHistory stored on-chain (copy to storage deeply)
        bidHistory.push(Bid({
            bidder: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp // current block timestamp (unit second)
        }));

        // If has prevBidder and prevBid, return the previous Ether to the preBidder.
        if (prevBid > 0) {
            // transform prevBidder to "address payable"
            payable(prevBidder).transfer(prevBid); 
        }
    }

    // 2. auction ended, only owner can call this function
    function endAuction() external {
        require(msg.sender == owner, 'Only owner can end the auction');
        require(!isAuctionEnded, 'auction already ended');

        // --- local variables start ---
        // record the highest bidder and bid finnally
        // address finalWinner = highestBidder;
        uint finalAmount = highestBid;
        // --- local variables end ---

        isAuctionEnded = true; // update auction state to ended
        payable(owner).transfer(finalAmount);
    }
}