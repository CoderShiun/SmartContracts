// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint) {
        uint z = x + y;
        require(z >= x, "uint overflow");

        return z;
    }
}

library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

contract TestSafeMath {
    using SafeMath for uint256;
    using Math for uint256;

    uint256 public MAX_UINT = 2**256 - 1;

    function testAdd(uint256 x, uint256 y) public pure returns(uint256) {
        return x.add(y);
    }

    function testSqut(uint256 x) public pure returns(uint256) {
        return x.sqrt();
    }

    function testSqut2(uint256 x) public pure returns(uint256) {
        return Math.sqrt(x);
    }
}

library Array {
    // Array function to delete element at index and re-organize the array
    // so that their are no gaps between the elements.
    function remove(uint256[] storage _arr, uint256 _index) public returns(uint256[] memory) {
        require(_index>=0 && _arr.length >0, "wrong inputs");
        _arr[_index] = _arr[_arr.length -1];
        _arr.pop();

        return _arr;
    }
}

contract testArray {
    using Array for uint256[];

    uint256[] public myArr;

    function testRemove() public {
        for (uint256 i = 0; i < 10; i++) {
            myArr.push(i);
        }

        myArr.remove(1);

        //assert(myArr.length == 9);
        //assert(myArr[0] == 0);
        //assert(myArr[1] == 9);
        //assert(myArr[2] == 2);
        //assert(myArr[myArr.length-1] == 8);
    }
}