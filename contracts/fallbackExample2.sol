// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Receiver{
    event Received(address caller,uint amount,string message);

    receive() external payable{
        emit Received(msg.sender,msg.value,"receive is called");
    }

    //这个fallback也可以,但不能返回数据
    // fallback () external payable{
    //     emit Received(msg.sender,msg.value,"fallback is called");
    // }

    fallback(bytes calldata) external payable returns (bytes memory){
        emit Received(msg.sender,msg.value,"fallback is called");
        return "fallback called";
    }

    function deposit(string memory str) external payable returns (string memory){
        emit Received(msg.sender,msg.value,"deposit is called");
        return str;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function getAddress() public view returns (address){
        return address(this);
    }
}

contract Caller {

    Receiver receier;

    event Response(bool success,bytes data);

    constructor(){
        receier = new Receiver();
    }

    function testCall() public payable{
        
        //msg.data为空,所以执行Receiver合约中的receive函数
        //call函数返回值中的data的值是接收了此次发送的ether的那个函数的返回值,receive函数没有返回值
        //(bool success,bytes memory data) = address(receier).call{value:msg.value}("");

        // //msg.data不为空(尽管也没有什么意义),执行Receiver合约中的fallback函数
        // //call函数返回值中的data的值是接收了此次发送的ether的那个函数的返回值,fallback返回了“fallback called”
         (bool success,bytes memory data) = address(receier).call{value:msg.value}("aaa");

        //msg.data不为空,是Receiver合约中的函数
        //call函数返回值中的data的值是call参数中指定的函数的返回值
        //(bool success,bytes memory data) = address(receier).call{value:msg.value}(abi.encodeWithSignature("deposit(string)","deposit called"));

        emit Response(success,data);
    }

    function getBalance() public view returns (uint){
        return receier.getBalance();
    }

    function getAddress() public view returns (address){
        return receier.getAddress();
    }
}