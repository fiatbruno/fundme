//SPDX-License-Identifier: MIT

// Get funds from users
// Allow owner to withdraw funds
// And set minimum funding amount in USD


pragma solidity 0.8.17;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) addressToAmountFunded;


    function fund() public payable {

        // Require check for the condition #1
        // And reverts when the condition is false
        // Reverting: Undoing everything prior and sending remaining gas back.

        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    // function withdraw() public
}