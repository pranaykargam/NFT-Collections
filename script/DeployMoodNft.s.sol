// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";
import {Test, console} from "forge-std/Test.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadsvg = vm.readFile("./images/sad.svg");
        string memory happysvg = vm.readFile("./images/happy.svg");

        console.log("Sad SVG:", sadsvg);

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageUri(sadsvg),
            svgToImageUri(happysvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory svgBase64Encoded = Base64.encode(
            bytes(string.concat("data:image/svg+xml;base64,", svg))
        );
        return svgBase64Encoded;
    }
}
