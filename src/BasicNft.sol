// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private sTokenCounter;
    mapping(uint256 => string) private sTokenIdToUri;

    constructor() ERC721("puggy", "PUG") {
        sTokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public returns (uint256) {
        sTokenIdToUri[sTokenCounter] = tokenUri;
        _safeMint(msg.sender, sTokenCounter);
        sTokenCounter++;

        testTokenCounter();
        return sTokenCounter - 1;
    }

    function testTokenCounter() public view returns (uint256) {
        return sTokenCounter;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return sTokenIdToUri[tokenId];
    }
}
