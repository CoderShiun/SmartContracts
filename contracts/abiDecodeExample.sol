// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract ABI {
    struct MyStruct {
        string name;
        uint256[2] nums;
    }

    function encodeABI(uint256 x, address addr, uint256[] memory arr, MyStruct calldata stru) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, stru);
    }

    function decodeABI(bytes calldata data) external pure returns(uint256 x, address addr, bytes memory arr, MyStruct memory stru) {
        return abi.decode(data, (uint256, address, bytes, MyStruct));
    }
}