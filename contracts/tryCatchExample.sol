// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "wrong address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint256 _num) public pure returns(string memory) {
        require(_num != 0, "wrong number");
        return "my function is called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        foo = new Foo(msg.sender);
    }

    function tryCatchExternalCall(uint256 _num) public {
        try foo.myFunc(_num) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("call myFunc error");
        }
    }

    function tryCatchCreateNewContract(address _addr) public {
        try new Foo(_addr) returns (Foo foo) {
            emit Log("create contract successful");
        } catch Error(string memory error) {
            emit Log(error);
        } catch (bytes memory reason) {
            emit LogBytes(reason);
        }
    }
}