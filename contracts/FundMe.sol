//SPDX-License-Identifier: MIT

// Get funds from users
// Allow owner to withdraw funds
// And set minimum funding amount in USD


pragma solidity 0.8.17;

contract FundMe{

    function fund() public payable {
        require(msg.value > 1e18, "Didn't send enough ETH");
    }
    
    
}