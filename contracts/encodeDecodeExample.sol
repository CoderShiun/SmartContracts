// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract EncodeDecode {
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xAA";
    uint[2] array = [5, 6]; 

    function encode(uint _x, address _addr, string calldata _name, uint[] calldata _array) public pure returns(bytes memory) {
        return abi.encode(_x, _addr, _name, _array);
    }

    function decode(bytes calldata _data) public pure returns (uint _x, address _addr, string memory _name, uint[2] memory _array) {
        (_x, _addr, _name, _array) = abi.decode(_data, (uint, address, string, uint[2]));
    }
    
}