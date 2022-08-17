// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract Pair {
    address public factory;
    address public token1;
    address public token2;

    constructor() {
        factory = msg.sender;
    }

    function init(address _token1, address _token2) external {
        require(factory == msg.sender, "unavailable.");

        token1 = _token1;
        token2 = _token2;
    }
}

contract PairFactory2 {
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    function createPair2(address _tokenA, address _tokenB) external returns(address pairAddress) {
        (address token1, address token2) = _tokenA > _tokenB ? (_tokenA, _tokenB) : (_tokenA, _tokenB);
        bytes32 salt = keccak256(abi.encodePacked(token1, token2));

        Pair pair2 = new Pair{salt: salt}();
        pair2.init(token1, token2);

        address pair2Addr = address(pair2);
        allPairs.push(pair2Addr);
        getPair[_tokenA][_tokenB] = pair2Addr;
        getPair[_tokenB][_tokenA] = pair2Addr;

        return pair2Addr;
    }

    function calculateAddr(address _tokenA, address _tokenB) external view returns(address) {
        bytes32 salt = keccak256(abi.encodePacked(_tokenA, _tokenB));

        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(type(Pair).creationCode)
        )))));

        
        return predictedAddress;
    }
}