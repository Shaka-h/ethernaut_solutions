// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console2} from "forge-std/Script.sol";
import {Telephone} from "../src/Telephone.sol";
import {IntermediateContract} from "../src/IntermediateContract.sol";

contract DeployIntermediate is Script {
    IntermediateContract intermediate;

    function run() external {
        vm.startBroadcast();

        // Deploy IntermediateContract
        intermediate = new IntermediateContract();
        console2.log("IntermediateContract deployed at:", address(intermediate));

        vm.stopBroadcast();
    }
}
