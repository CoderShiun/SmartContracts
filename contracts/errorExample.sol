// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract Err {
    function testRevert(uint256 _num) public pure {
        if (_num < 10) {
            revert("number is too small.");
        }
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomerError(uint256 _withdrawAmount) public view {
        if (_withdrawAmount > address(this).balance) {
            revert InsufficientBalance({balance: address(this).balance, withdrawAmount: _withdrawAmount});
        }
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}