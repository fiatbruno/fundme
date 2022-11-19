//SPDX-License-Identifier: MIT

// Get funds from users
// Allow owner to withdraw funds
// And set minimum funding amount in USD


pragma solidity 0.8.17;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 minimumUsd = 50 * 1e18;
    address owner;
    address[] public funders;
    mapping(address => uint256) addressToAmountFunded;

    constructor(){
        owner = msg.sender; 
    }


    function fund() public payable {

        // Require check for the condition #1
        // And reverts when the condition is false
        // Reverting: Undoing everything prior and sending remaining gas back.

        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function withdraw() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // // Allow of these are way to send ETH or any other native 
        // // blochain token from a contract an address

        // //transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        // //send
        // bool sendResponse = payable(msg.sender).send(address(this).balance);
        // require(sendResponse, "Failed to withdraw funds with send");
        
        //call
        (bool callResponse,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callResponse, "Failed to withdraw funds with call");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "ONLY THE OWNER CAN WITHDRAW");
        _;
    }
}