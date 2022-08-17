// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

contract Array {
    uint256[] public arr1;
    uint256[] public arr2 = [1,2,3];
    uint256[5] public myFixedSizeArray;

    function get(uint256 _index) public view returns(uint256) {
        return arr1[_index];
    }

    function getArray() public view returns(uint256[] memory) {
        return arr1;
    }

    function push(uint256 _num) public {
        arr1.push(_num);
    }

    function pop() public {
        arr1.pop();
    }

    function remove(uint256 _index) public {
        delete arr1[_index];
    }

    function getArrayLength() public view returns(uint256 l) {
        return arr1.length;
    }
}