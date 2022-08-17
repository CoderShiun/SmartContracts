// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

interface IABI {
    function init(address a, address b, address c, address d) external;
}

contract ABI {
    // function init(address a, address b, address c, address d) public {}

    function getCodeByKeccak() public pure returns(bytes4) {
        return bytes4(keccak256(bytes("init(address,address,address,address)")));
    }

    function getCodeBySelector() public view returns(bytes4) {
        IABI addr = IABI(address(this));
        return addr.init.selector;
    }
}