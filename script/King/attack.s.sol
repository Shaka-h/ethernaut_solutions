// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ForeverKing} from "../src/ForeverKing.sol";
import {King} from "../src/King.sol";
import {DeployAttackScript} from "../script/DeployAttack.s.sol";

contract AttackScript is Script {
    DeployAttackScript public deployAttackScript;
    ForeverKing public foreverKing;
    King public king;

    function run() public {
        deployAttackScript = new DeployAttackScript();
        (foreverKing, king ) = deployAttackScript.run();

        attackKing();
    }


    function attackKing () public {
        
        vm.startBroadcast();

        foreverKing.makeMeKing();

        vm.stopBroadcast();

    }

}