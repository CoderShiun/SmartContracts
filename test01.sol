// "SPDX-License-Identifier: UNLICENSED" 
pragma solidity ^0.7.0;

contract MyEvent {
    uint public count;

    event IncreaseMent(address _address);

    function increase() public {
        emit IncreaseMent(msg.sender);
        count++;
    }

    function getMsgSender() public view returns(address){
        return msg.sender;
    }

    function getBalance() public view returns(uint) {
        return msg.sender.balance;
    }
}

contract WithdrawTest {
    function sendToContract() public payable {
        payable(address(this)).transfer(msg.value);
    }

    function withdraw() public payable {
        payable (msg.sender).transfer(address(this).balance);
    }

    function sendToSomeone(address addr) public payable {
        payable (addr).transfer(1 ether);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    fallback() external {

    }

    receive() payable external {
        
    }
}