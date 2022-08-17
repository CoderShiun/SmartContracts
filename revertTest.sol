// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

import "hardhat/console.sol";

contract revertFuncTest {
    function revertTest() external pure {
        revert("here revert");
    }

    function testMsg() public {
        console.log(msg.sender);
        //console.log(msg.data);
    }

    fallback() external {
        console.log("here got fallback.");
    }
}