// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract FallBackExample {
    uint256 public result;

    // receive is onlt triggered if the call data is blank
    receive() external payable {
        result = 1;
    }

    // fallback is called when function put in call data is not defined
    fallback() external payable {
        result = 2;
    }
    // Fallback, receive, contructor are some special functions which do not need function keyword to be used
        
}