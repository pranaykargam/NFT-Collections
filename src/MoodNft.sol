// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
contract MoodNft is ERC721 {
   uint256 private sTokenCounter;
   string private sadSvg;
   string private happySvg; 
        constructor(
        string memory sadsvg,
        string memory happysvg
    ) ERC721("MoodNft", "MN") {
        sTokenCounter = 0;
        sadSvg = sadsvg;
        happySvg = happysvg;
    }
    function mintNft()public returns(uint256){
        uint256 newTokenId = sTokenCounter;
        _safeMint(msg.sender, newTokenId);
        sTokenCounter += 1;
        return newTokenId;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory){}
}