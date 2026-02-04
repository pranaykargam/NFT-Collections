// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";




contract MintBasicNft is Script {
    function run() external{
        // Allow overriding the target contract via env var to avoid reading broadcast artifacts
        address envAddr = vm.envAddress("CONTRACT_ADDRESS");
        if (envAddr != address(0)) {
            mintNftOnContract(envAddr);
            return;
        }

        address mostRecentBasicNft = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentBasicNft);
}

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft basicNft = BasicNft(contractAddress);
        basicNft.mintNft("PUG");
        vm.stopBroadcast();
        
}
}