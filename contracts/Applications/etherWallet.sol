// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract EthWallet {
    address owner;
    
    constructor() {
        owner = payable(msg.sender);
    }

    modifier checkWithdraw(uint256 _amount) {
        require(owner == msg.sender, "not the contract owner.");
        require(_amount < address(this).balance, "insufficient balance.");
        _;
    }

    function withdraw(uint256 _amount) public checkWithdraw(_amount) {
        payable(owner).transfer(_amount * 1 ether);
    }

    function topUp() public payable {
        payable(address(this)).transfer(msg.value);
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    receive() external payable{}
}