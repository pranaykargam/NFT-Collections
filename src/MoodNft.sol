// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private i_sadSvgImageUri;
    string private i_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvg,
        string memory happySvg
    ) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        i_sadSvgImageUri = svgToImageURI(sadSvg);
        i_happySvgImageUri = svgToImageURI(happySvg);
    }

    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        // data:image/svg+xml;base64,<base64-encoded-svg>
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function mintNft() public returns (uint256) {
        uint256 newTokenId = s_tokenCounter;
        _safeMint(msg.sender, newTokenId);
        s_tokenIdToMood[newTokenId] = Mood.HAPPY;
        s_tokenCounter += 1;
        return newTokenId;
    }

    function flipMood(uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        // Only owner or approved can flip
        _checkAuthorized(owner, msg.sender, tokenId);

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        // data:application/json;base64,<base64-encoded-json>
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        // standard OZ 721 check
        _requireOwned(tokenId);

        string memory imageURI = i_happySvgImageUri;
        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = i_sadSvgImageUri;
        }

        bytes memory metadata = abi.encodePacked(
            '{"name":"Mood NFT",',
            '"description":"An NFT that reflects the owner\'s mood.",',
            '"attributes":[{"trait_type":"mood","value":"',
            s_tokenIdToMood[tokenId] == Mood.HAPPY ? "happy" : "sad",
            '"}],',
            '"image":"',
            imageURI,
            '"}'
        );

        string memory encodedMetadata = Base64.encode(metadata);

        return string(abi.encodePacked(_baseURI(), encodedMetadata));
    }
}
