// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Fallback {
    event Test(uint256 gas, string _msg);

    fallback() external payable {
        emit Test(gasleft(), "fallback");
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool ok, bytes memory data) = _to.call{value: msg.value}("");
        require(ok, "not ok");
    }
}