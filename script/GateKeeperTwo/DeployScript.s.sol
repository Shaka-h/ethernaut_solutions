// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {Attack} from "../src/Attack.sol";

contract DeployScript is Script {
    Attack intermediate;
    GatekeeperTwo gatekeeperTwo;

    function run() external returns (Attack, GatekeeperTwo) {
        vm.startBroadcast();

        gatekeeperTwo = new GatekeeperTwo();
        
        // intermediate = new Attack(gatekeeperTwo);
        intermediate = new Attack(GatekeeperTwo(0x0fcd2a334573931dC851C28A709Bcc888428C41f));

        vm.stopBroadcast();

        return (intermediate, gatekeeperTwo);
    }
}
