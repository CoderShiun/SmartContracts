// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Payable {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {}

    function getContractBalance() public view returns(uint256) {
        return owner.balance;
    }

    function notPayable() public {}

    function transfer(address payable _to, uint256 _amount) public {
        
    }
}