// Get Funds from Users
// Withdraw Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {PriceConvertor} from "./PriceConvertor.sol";

error NotOwner(); // here we practically created our own error type
contract FundMe {

    using PriceConvertor for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //msg.value is the first arguement being passed intot thefunction and baaki saare within the bracket
        require(msg.value.getConversionRate() > MINIMUM_USD, "Did not send enough ethers"); // 1 ether = 1 * 10 ** 18 wie
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    // Withdray functin should only be called by owner of the contract

    function withdraw () public onlyOwner {

        // we can not put this line to every owner fucntion so we use modifier
        // require(msg.sender == owner, "Must of owner");

        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // now we reset the array
        funders = new address[] (0);
        // now we actually withdraw the funds
        // there are 3 methods to do so with different implementations

        // 1. Transfer

        //msg.sender is type of address and payable type makes it payable account adddress
        // if it fails, it throws an error and returns a transaction
        payable(msg.sender).transfer(address(this).balance);

        // 2. Send
        // send will not give an error and instead return a boolean type
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");

        // 3. Call
        //   Used to call any function in all ethereum without having to call ABI
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); // we dont want to call any function so we leave empty and isntead wnat to use it as transaction
        // this function returns 2 values which are bool and bytes object
        // since we call different functions and if that function returns some data then it is stored as a bytes object
        require(callSuccess, "call failed");


    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Senedr is not owner"); THIS IS NOT GASS EFFICIENT
        if (msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    // What if someone sends ETH to the contract without calling the fund function.
    // 2 special function to solve the problem
    // recieve
    // fallback

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }

    
}