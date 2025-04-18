// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {Attack} from "../src/Attack.sol";
import {DeployScript} from "../script/DeployScript.s.sol";
import {Script, console2} from "forge-std/Script.sol";

contract AttackScript is Script {
    GatekeeperTwo public gatekeeperTwo;
    Attack public attack;
    DeployScript public deployScript;

    function run() public {
        deployScript = new DeployScript();
        (attack, gatekeeperTwo) = deployScript.run();
        
        attackForce(gatekeeperTwo);
    }

    function attackForce (GatekeeperTwo _gatekeeperTwo) public {
        
        vm.startBroadcast();

        attack.attack(_gatekeeperTwo);

        vm.stopBroadcast();

    }

}
