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

    function testConverSvgToUri() public view{  
        // Multiline SVG matching your hardcoded expectedUri exactly
        string memory svg = unicode"<!DOCTYPE html>\n<html>\n<body>\n\n<h1>My first SVG</h1>\n\n<svg width=\"400\" height=\"100\" xmlns=\"http://www.w3.org/2000/svg\">\n  <text x=\"10\" y=\"60\" fill=\"green\" font-size=\"32\">\n    hyy!!! nfts are fun\n  </text>\n  Sorry, your browser does not support inline SVG.\n</svg>\n\n</body>\n</html>";
        
        string memory expectedUri = "data:image/svg+xml;base64,PCFET0NUWVBFIGh0bWw+CjxodG1sPgo8Ym9keT4KCjxoMT5NeSBmaXJzdCBTVkc8L2gxPgoKPHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8dGV4dCB4PSIxMCIgeT0iNjAiIGZpbGw9ImdyZWVuIiBmb250LXNpemU9IjMyIj4KICAgIGh5eSEhISBuZnRzIGFyZSBmdW4KICA8L3RleHQ+CiAgU29ycnksIHlvdXIgYnJvd3NlciBkb2VzIG5vdCBzdXBwb3J0IGlubGluZSBTVkcuCjwvc3ZnPgoKPC9ib2R5Pgo8L2h0bWw+Cg==";
        
        
        string memory createdUri = deployer.svgToImageUri(svg);
        
        // Debug log (remove after passing)
        console.log("Created URI len:", bytes(createdUri).length);
        console.log("Expected URI len:", bytes(expectedUri).length);
        
        assertEq(createdUri, expectedUri);
    }
}
