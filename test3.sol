// SPDX-License-Identifier: SimPL-3.0
pragma solidity ^0.7.0;

contract MultiSig {
    address s0;
    address s1;
    address s2;
    bool registered;
    uint numSigned;
    mapping(address => bool) signed;
    string error;

    constructor() {
        s0 = msg.sender;
        registered = false;
    }

    modifier onlyOwner() {
        require(
            msg.sender == s0,
            "you are not the woner."
            );

        _;
    }

    modifier registerDone() {
        require(
            registered,
            "not register all the sig yet."
        );
        _;
    }

    modifier M2N3() {
        require(numSigned >= 2,
        "not enough sig.");
        _;
    }

    function register(address sig1, address sig2) public onlyOwner() {
        if (!registered) {
            s1 = sig1;
            s2 = sig2;
            registered = true;
        } else if (registered) {
            error = "already registered.";
        }
    }

    function addSignature() public registerDone() {
        if (msg.sender == s0 && signed[s0]==false){
            signed[msg.sender]=true;
            numSigned++;
        } else if (msg.sender == s1 && signed[s1]==false) {
            signed[msg.sender]=true;
            numSigned++;
        } else if (msg.sender == s2 && signed[s2]==false) {
            signed[msg.sender]=true;
            numSigned++;
        } else {
            error = "unknown address.";
        }
    }

    function withdraw(address to) public payable registerDone() M2N3(){
        if (msg.sender == s0 || msg.sender == s1 || msg.sender == s2) {
            payable(to).transfer(msg.value);
            numSigned = 0;
            signed[s0] = signed[s1] = signed[s2] = false;
        } else {
            error = "not enough sign.";
            revert("not yet.");
        }
    }

    function getErr() public view returns(string memory) {
        return error;
    }

    function getNumSigned() public view returns(uint) {
        return numSigned;
    }

    fallback() external {}

    receive() payable external {}
}