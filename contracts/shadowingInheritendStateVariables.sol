// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract A {
    string public name = "Contract A";

    function get() public view returns(string memory) {
        return name;
    }

    function set(string memory _name) public {
        name = _name;
    }
}

contract B is A {
    constructor() {
        // name = "Changed";
    }

    function getFromB() public view returns(string memory) {
        return name;
    }
}