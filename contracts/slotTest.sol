// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Slots {
    address owner;

    constructor() {
        // owner = msg.sender;
    }

    function get() public view {
        console.log("exc revert");
        revert();
    }

    receive() external payable {
        console.log("receive");
    }

    fallback() external payable {
        console.log("fallback");
    }
}

contract TestSlot {
    Slots slo;

    function testFunc() public payable {
        //console.log("call Contract.");
        payable (address (slo)).transfer(2 ether);
        //slo.get();
    }

    fallback() external {
        console.log("fallback in c2.");
    }
}


contract Test {
   uint public x ;

   function getX() public view returns(uint) {
       return x;
   }

   fallback() external { 
       console.log("fallback in xxxxxxx.");
       x = 1; }    
}
contract Sink {
   fallback() external payable { 
       console.log("fallback in yyyyyyyyyy.");
   }
}
contract Caller {
   function callTest(Test test) public returns (bool) {
      (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
      //require(success);
      // test.x 是 1
      address payable testPayable = payable (address(uint160(address(test))));
      // 发送以太测试合同,
      // 转账将失败，也就是说，这里返回false。
      return (testPayable.send(2 ether));
   }
   function callSink(Sink sink) public returns (bool) {
      address payable sinkPayable = payable (address(sink));
      return (sinkPayable.send(2 ether));
   }

   fallback() external {
       console.log("my own fallback.");
   }
}