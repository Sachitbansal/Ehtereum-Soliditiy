// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract SimpleStorage {
    uint256 myFavNumber;
    // uint256[] listOfFavNumbers;

    struct Person {
        uint256 favnumber;
        string name;
    }

    // Dyamic array
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavNum;


    function store (uint256 _favnumber) public virtual{
        myFavNumber = _favnumber;
    }

    function retrieve() public view returns(uint256) {
        return myFavNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        listOfPeople.push(Person(_favouriteNumber, _name));
        nameToFavNum[_name] = _favouriteNumber;
    }
}