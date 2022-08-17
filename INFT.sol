// SPDX-License-Identifier: SimPL-3.0
pragma solidity >= 0.8.0;

interface INFT {
    function setContractURI(string memory _contractURI) external returns(bool);
    function createToken(string memory _tokenURI) external returns(uint256 tokenID);
    function getInfo(uint256 _nftTokenID) external view returns(address, string memory, string memory, string memory);
    function getTokens(address _user) external returns(uint256[] memory);
}