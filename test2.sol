// SPDX-License-Identifier: SimPL-3.0
pragma solidity ^0.7.0;

contract PubDonee {
    struct Donee {
        string projectName;
        address addr;
        uint goal;
        uint sum;
        uint donorCount;
        bool status;
        mapping(uint => Doner) donerDict;
    }

    struct Doner {
        string name;
        uint amount;
        address addr;
    }

    uint doneeCount;
    mapping(uint => Donee) doneeDict;

    address payable owner;

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "you are not the contract owner!"
        );
        _;
    }

    modifier verifyDonee(uint doneeID) {
        require(doneeID > 0 && doneeID <= doneeCount);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function destroyContract() public onlyOwner {
        selfdestruct(owner);
    }

    function setDonee(string memory name, address addr, uint goal) public onlyOwner {
        doneeCount ++;
        Donee storage newDonee = doneeDict[doneeCount];
        newDonee.projectName = name;
        newDonee.addr = addr;
        newDonee.goal = goal;
        newDonee.status = true;
    }

    function donate(uint doneeID, string memory donerName) public payable verifyDonee(doneeID) {
        Donee storage donee = doneeDict[doneeID];
        require(donee.status);
        donee.sum += msg.value;
        donee.donorCount ++;

        Doner storage newDoner = donee.donerDict[donee.donorCount];
        newDoner.name = donerName;
        newDoner.amount = msg.value;
        newDoner.addr = msg.sender;
    }

    function transferToDonee(uint doneeID) public payable onlyOwner verifyDonee(doneeID) {
        Donee storage donee = doneeDict[doneeID];
        if (donee.sum > donee.goal) {
            payable(donee.addr).transfer(donee.sum);
        } else {
            revert("not enough.");
        }
    }

    // 合约转账到拥有者
    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function getDoneeStatus(uint doneeID) public view returns(string memory name, address addr, uint goal, uint sum, uint donorCount) {
        return (doneeDict[doneeID].projectName, doneeDict[doneeID].addr, doneeDict[doneeID].goal, doneeDict[doneeID].sum, doneeDict[doneeID].donorCount);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    fallback() external {

    }

    receive() payable external {
        
    }

}