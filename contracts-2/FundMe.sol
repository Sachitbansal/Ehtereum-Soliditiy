// Get Funds from Users
// Withdraw Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {PriceConvertor} from "./PriceConvertor.sol";
contract FundMe {

    using PriceConvertor for uint256;

    uint256 public minimumUSD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //msg.value is the first arguement being passed intot thefunction and baaki saare within the bracket
        require(msg.value.getConversionRate() > minimumUSD, "Did not send enough ethers"); // 1 ether = 1 * 10 ** 18 wie
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }

    function withdraw () public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {

        }
    }

    
}