// SPDX-License-Identifier: SimPL-3.0
pragma solidity >= 0.8.0;

contract myTest {
    struct myStruct {
        uint age;
        bytes32 name;
        mapping(uint => bool) myMap;
    }

    function setStruct() public {
        uint256 s = 1;
        // myStruct storage ms = myStruct(1 , "aa", m);
    }

    function t(string memory aa) public {
        
    }
}

library Search {
   function indexOf(uint[] storage self, uint value) public view returns (uint256) {
      for (uint i = 0; i < self.length; i++) {
          if (self[i] == value) {
              return i;
            }
      }
      
      return type(uint256).max;
   }

   function libraryTest(address) public returns(uint256){
       return 1;
   }
}

contract FunctionModifiers{
    address payable public creator;
    address a;
    using Search for address;
    
    function functionModifiers() public {
        creator = payable(msg.sender);
    }
    
    modifier onlyCreator() {
        if(msg.sender!=creator){
            revert(); 
        }
        
        _; //在函数修改器修改完毕后恢复函数
    }
    
    function killContract() public onlyCreator{ 
    //不出意外的话，修改后的函数可以正常调用。
        a.libraryTest();
        selfdestruct(creator); 
    }
}

contract Test {
   using Search for uint[];
   uint[] data;
   constructor() public {
      data.push(1);
      data.push(2);
      data.push(3);
      data.push(4);
      data.push(5);
   }
   function isValuePresent() external view returns(uint){
      uint value = 4;      

      // data 表示库
      uint index = data.indexOf(value);
      return index;
   }
}