// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        value = msg.value;
        sender = msg.sender;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function getSelector(string calldata _func) internal pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    //function setVars(address _contrAddr, uint256 _num) public payable {
    //    bytes4 f = getSelector("aaa");

    //    (bool ok, bytes memory data) = _contrAddr.delegatecall(
            //abi.encodeWithSignature("setVars(uint256)", _num)
    //        f
    //    );
    //}
}