// Get Funds from Users
// Withdraw Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract FundMe {

    uint256 public minimumUSD = 5;

    function fund() public payable {
        
        
        require(msg.value > minimumUSD, "Did not send enough ethers"); // 1 ether = 1 * 10 ** 18 wie
    }

    function getPrice() public {

        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
    }
    function getConversionRate() public {}

    // What does revert do?
    // Undo any action that has been done and send  the remaining gas back
    
}