// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract MoodNft is ERC721 {
    /* errors */
    error MoodNft__CanNotFlipMoodIfNotOwner();

    uint256 private sTokenCounter;
    string private iSadSvgImageUri;
    string private iHappySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    function getMood(uint256 tokenId) external view returns (Mood) {
        return s_tokenIdToMood[tokenId];
    }

    constructor(string memory sadSvg, string memory happySvg) ERC721("MoodNft", "MN") {
        sTokenCounter = 0;
        iSadSvgImageUri = svgToImageUri(sadSvg);
        iHappySvgImageUri = svgToImageUri(happySvg);
    }

    function svgToImageUri(string memory svg) public pure returns (string memory) {
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked("data:image/svg+xml;base64,", svgBase64Encoded));
    }

    function mintNft() public returns (uint256) {
        uint256 newTokenId = sTokenCounter;
        _safeMint(msg.sender, newTokenId);
        s_tokenIdToMood[newTokenId] = Mood.HAPPY;
        sTokenCounter += 1;
        return newTokenId;
    }

    /*//////////////////////////////////////////////////////////////
                                FLIPMOOD
    //////////////////////////////////////////////////////////////*/
    function flipMood(uint256 tokenId) public {
        if (ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CanNotFlipMoodIfNotOwner();
        }
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

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // standard OZ 721 check
        _requireOwned(tokenId);

        string memory imageURI = s_tokenIdToMood[tokenId] == Mood.SAD ? iSadSvgImageUri : iHappySvgImageUri;

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
