// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract HashTest {
    function hash(string calldata _text, uint256 _num, address _addr) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    function collisionEncode(string calldata _text1, string calldata _text2) public pure returns (bytes32) {
        return keccak256(abi.encode(_text1, _text2));
    }

    function collisionEncode2(string calldata _text1, string calldata _text2) public pure returns (bytes32) {
        return keccak256(abi.encode(_text1, _text2));
    }

    function collisionEncodePacked(string calldata _text1, string calldata _text2) public pure returns (bytes32) {
        return keccak256(abi.encode(_text1, _text2));
    }

    function collisionEncodePacked2(string calldata _text1, string calldata _text2) public pure returns (bytes32) {
        return keccak256(abi.encode(_text1, _text2));
    }
}

contract GuessTheMagicWord {
    bytes32 public answer = 0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    function guess(string calldata _text) public view returns (bool) {
        return keccak256(abi.encodePacked(_text)) == answer;
    }
}