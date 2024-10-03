// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConvertor{
    function getPrice() internal view returns (uint256){

        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceFeed.latestRoundData();
        //ethereum does not work with decimal and does not support float data type
        // so we need to know the decimal places
        // 1 ETH = 1e18 wie
        // the function we have applied gives us 8 decimal places bu default and we need to put other 10 buy our selves 
        // msg.vallue is a uint256 and price var is a int256 so we need to typecase price to uint256

        return uint256(price * 1e10);
    }
    function getConversionRate(uint256 eathAmount) internal view returns(uint256) {

        // now we have to convert msg.value eth to usd to compare
        uint256 ethPrice = getPrice();
        uint256 eathAmountInUSD = (ethPrice * eathAmount)/ 1e18 ;
        return eathAmountInUSD;
    }

    // What does revert do?
    // Undo any action that has been done and send  the remaining gas back
    
    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}