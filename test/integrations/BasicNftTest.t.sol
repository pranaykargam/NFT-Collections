// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public puppyNft;
    address public user = makeAddr("user");
    string public constant PUG = "ipfs://QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/6369.png";

    function setUp() public {
        deployer = new DeployBasicNft();
        puppyNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "puggy";
        string memory actualName = puppyNft.name();
        // asset(expectedName == actualName);
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }
}

