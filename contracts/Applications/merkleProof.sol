// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract MerkelProof {
    function verify(bytes32[] memory proof, bytes32 leaf, bytes32 root, uint256 index) internal pure returns(bool) {
        bytes32 hash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }

        return hash == root;
    }
}

contract TestMerkleProof is MerkelProof {
    bytes32[] hashes;

    constructor() {
        string[4] memory transactions = [
        "alice -> bob",
        "bob -> dave",
        "carol -> alice",
        "dave -> bob"
        ];

        for (uint256 i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        uint txLength = transactions.length;
        uint256 offset = 0;

        while (txLength > 0) {
            for (uint256 i = 0; i < txLength-1; i += 2) {
                hashes.push(keccak256(abi.encodePacked(
                    hashes[offset + i], hashes[offset + i +1]
                )));
            }
            offset += txLength;
            txLength = txLength / 2;
        }
    }

    function getRoot() public view returns(bytes32) {
        return hashes[hashes.length-1];
    }

    function getHashesLength() public view returns(uint256) {
        return hashes.length;
    }
}