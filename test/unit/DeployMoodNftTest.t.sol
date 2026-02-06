// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConverSvgToUri() public view {
        // Multiline SVG matching your hardcoded expectedUri exactly
        string memory svg =
            unicode"<svg width=\"400\" height=\"100\" xmlns=\"http://www.w3.org/2000/svg\"><text x=\"10\" y=\"60\" fill=\"green\" font-size=\"32\">hyy!!! nfts are fun</text></svg>";
        string memory expectedUri =
            "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGV4dCB4PSIxMCIgeT0iNjAiIGZpbGw9ImdyZWVuIiBmb250LXNpemU9IjMyIj5oeXkhISEgbmZ0cyBhcmUgZnVuPC90ZXh0Pjwvc3ZnPg==";

        string memory createdUri = deployer.svgToImageUri(svg);
        console.log(createdUri);
        assertEq(createdUri, expectedUri);
    }
}
