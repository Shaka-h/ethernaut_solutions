// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Force} from "../src/Force.sol";
import {Attack} from "../src/Attack.sol";
import {DeployAttackScript} from "../script/DeployAttack.s.sol";

contract AttackScript is Script {
    DeployAttackScript public deployAttackScript;
    Force public force;
    Attack public attack;

    function run() public {
        deployAttackScript = new DeployAttackScript();
        (force, attack ) = deployAttackScript.run();

        attackForce();
    }


    function attackForce () public {
        
        vm.startBroadcast();

        console.log("Attack Balance:", address(attack).balance);

        (bool sent, ) = address(attack).call{value: address(attack).balance}("");

        console.log("Attack Balance:", sent, address(attack).balance);

        vm.stopBroadcast();

    }

}