// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EventTest {
    event testEvent(address who, bytes32 msg);
    event transEvent(address who, bytes32 msg);

    uint256 p;

    function triggleEvent() internal {
        emit testEvent(msg.sender, "here is the test event message.");
    }

    function transAlarm() internal {
        emit transEvent(msg.sender, "wrong tx.");
    }
}

contract MyContract is EventTest {
    address owner;

    event myEvent(bytes32 msg);

    bool equal = 1 ether == 1e18;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not the contract owner.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function sendEvent() public {
        super.triggleEvent();
    }

    function sendMyEvent() public {
        emit myEvent("here is my event");
    }

    function sendToken(address to) public payable onlyOwner {
        if (to.balance > msg.value) {
            payable(to).transfer(msg.value);
        } else {
            revert("not enough balance.");
        }
    }
}

contract MappingTest {
    mapping(address => mapping(uint => bool)) public nested;

    mapping(address => mapping(uint => bool)) public newMap;

    mapping(uint => address) m2;

    bytes myBytes;
    string myString;
    uint myNum;

    function setMyMap(address _addr) public {
        nested[_addr][1] = true;

        delete nested[_addr][1];
        delete  myNum;

        delete myBytes;
        delete myString;
        delete m2[1];
    }

    function test(uint256 num) public {
        
    }
}