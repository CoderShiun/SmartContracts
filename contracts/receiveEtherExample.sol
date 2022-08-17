// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract ReceiveEther {
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    receive() external payable {}

    fallback() external payable {}
}

contract SendEther {
    function snedViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        (bool ok) = _to.send(msg.value);
        require(ok, "send not ok");
    }

    function sendViaCall(address payable _to) public payable {
        (bool ok, bytes memory data) = _to.call{value: msg.value}("what is this?");
        //console.log(data);
        require(ok, "send via call not ok");
    }
}