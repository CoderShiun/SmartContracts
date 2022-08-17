// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

interface ICounter {
    function get() external view returns(uint256);

    function increase() external;

    function decrease() external;
}

contract Counter {
    uint public count;

    function increase() external {
        count++;
    }

    function decrease() external {
        count--;
    }

    function get() external view returns(uint256) {
        return count;
    }
}

contract UseCounter {
    address counterAddr;

    constructor(address _addr) {
        counterAddr = _addr;
    }

    //ICounter myCounter = ICounter(counterAddr);

    function inc() external {
        ICounter(counterAddr).increase();
    }

    function dec() public {
        ICounter(counterAddr).decrease();
    }

    function getMyNum() public view returns(uint256) {
        return ICounter(counterAddr).get();
    }
}

interface II {
    function test() external;
    function testII() external;
}

contract CtoI is II {
    function abc() public {

    }

    function test() external {
    }

    function testII() external {

    }
}

interface IAnimal {
    function eat() external returns(string memory);
}

contract Cat {
    function eat() external returns(string memory) {
        return "Cat eatting.";
    }
}

contract Dog {
    function eat() external returns(string memory) {
        return "Dog eatting.";
    }
}

contract Animal {
    function getEat(address _addr) public returns(string memory) {
        return IAnimal(_addr).eat();
    }
}