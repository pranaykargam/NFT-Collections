// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadsvg = vm.readFile("./images/sad.svg");
        string memory happysvg = vm.readFile("./images/happy.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(sadsvg, happysvg); // raw SVG
        vm.stopBroadcast();
        return moodNft;
    }

    // used only by DeployMoodNftTest
    function svgToImageUri(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}

