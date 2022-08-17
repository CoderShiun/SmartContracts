// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;
import "hardhat/console.sol";

contract VerifySignature {
    //address public sigAddr = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    function getMessageHash(address _to, uint256 _amount, string calldata _msg, uint256 _nonce) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _msg, _nonce));
    }

    function getEthSignedHash(bytes32 _hash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash));
    }

    function recoverSigner(bytes32 _ethSignedHash, bytes calldata _signature) public pure returns(address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedHash, v, r, s);
    }

    function splitSignature(bytes memory _signature) internal pure returns(bytes32 r, bytes32 s, uint8 v) {
        require(_signature.length == 65, "invalid signature");

        /*
        First 32 bytes stores the length of the signature

        add(sig, 32) = pointer of sig + 32
        effectively, skips first 32 bytes of signature

        mload(p) loads next 32 bytes starting at the memory address p into memory
        */
        
        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(_signature, 32))
            // second 32 bytes
            s := mload(add(_signature, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(_signature, 96)))
        }
    }

    function verify(address _signer, address _to, uint256 _amount, string calldata _msg, uint256 _nonce, bytes calldata _signature) public pure returns(bool) {
        bytes32 firstHash = getMessageHash(_to, _amount, _msg, _nonce);
        bytes32 finalHash = getEthSignedHash(firstHash);

        return recoverSigner(finalHash, _signature) == _signer;
    }
}