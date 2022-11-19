//SPDX-License-Identifier: MIT

// Get funds from users
// Allow owner to withdraw funds
// And set minimum funding amount in USD

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


pragma solidity 0.8.17;

contract FundMe{

    uint256 minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) addressToAmountFunded;


    function fund() public payable {

        // Require check for the condition #1
        // And reverts when the condition is false
        // Reverting: Undoing everything prior and sending remaining gas back.

        require(getConversionRate(msg.value) > minimumUsd, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }
    function getPrice() public view returns(uint256) {
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e;
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        
        // Returns price of ETH in USD
        (,int256 price,,,) = priceFeed.latestRoundData();

        return uint256(price * 1e10);

    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    
    // function withdraw() public
}