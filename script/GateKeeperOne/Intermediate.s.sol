// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {Attack} from "../src/IntermediateContract.sol";

contract DeployScript is Script {
    Attack intermediate;
    GatekeeperOne gatekeeperOne;

    function run() external returns (Attack, GatekeeperOne) {
        vm.startBroadcast();

        gatekeeperOne = new GatekeeperOne();
        
        // intermediate = new Attack(gatekeeperOne);
        intermediate = new Attack(GatekeeperOne(0xB11F9E9094ce829d7a226dd739715A83ce24Dc64));

        vm.stopBroadcast();

        return (intermediate, gatekeeperOne);
    }
}
