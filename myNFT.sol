// SPDX-License-Identifier: SimPL-3.0
pragma solidity >= 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./INFT.sol";

contract NFT is INFT, ERC721Enumerable, ERC721URIStorage {
    address public owner;
    uint256 public lastTokenID = 100000;
    string public contractURI;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        owner = msg.sender;
    }

    function setContractURI(string memory _contractURI) external override virtual returns(bool) {
        require(msg.sender == owner, 'NFT:4001');
        contractURI = _contractURI;
        return true;
    }

    function createToken(string memory _tokenURI) external override virtual returns(uint256 tokenID) {
        require(msg.sender == owner, 'NFT:4002');
        tokenID = mint(owner, _tokenURI);

        if (bytes(contractURI).length == 0) {
            contractURI = _tokenURI;
        }
    }

    function getInfo(uint256 _nftTokenID) external override virtual view returns(address ownerAddress, string memory name, string memory symbol, string memory _tokenURI) {
        ownerAddress = super.ownerOf(_nftTokenID);
        name = super.name();
        symbol = super.symbol();
        _tokenURI = tokenURI(_nftTokenID);
    }

    function tokenURI(uint256 _tokenID) public view virtual override(ERC721, ERC721URIStorage) returns(string memory toeknURI) {
        return super.tokenURI(_tokenID);
    }

    function mint(address _to, string memory _tokenURI) private returns(uint256) {
        lastTokenID++;
        _mint(_to, lastTokenID);
        _setTokenURI(lastTokenID, _tokenURI);
        return lastTokenID;
    }

    function _burn(uint256 _tokenID) internal virtual override(ERC721, ERC721URIStorage) {
        require(_tokenID > 0, 'GoShard:4003');
        super._burn(_tokenID);
    }

    function _beforeTokenTransfer(address _from, address _to, uint256 _tokenID) internal virtual override(ERC721, ERC721Enumerable) {
        // TODO...
        super._beforeTokenTransfer(_from, _to, _tokenID);
    }

    function supportsInterface(bytes4 _interfaceID) public view virtual override(ERC721, ERC721Enumerable) returns(bool) {
        return super.supportsInterface(_interfaceID);
    }

    function getTokens(address _user) public view virtual override returns(uint256[] memory tokens) {
        uint256[] memory _tokens = new uint256[](lastTokenID);
        uint256 index = 0;

        for (uint256 id = 10001; id <= lastTokenID; id++) {
            if (super.ownerOf(id) == _user) {
                _tokens[index] = id;
                index++;
            }
        }

        uint256[] memory userTokens = new uint256[](index);
        for (uint256 i=0; i<index; i++) {
            userTokens[i]=_tokens[i];
        }

        return userTokens;
    }
}