// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Shop} from "../src/Shop.sol";
import {Attacker} from "../src/ShopAttacker.sol";

contract DeployAttackScript is Script {
    Shop public shop;
    Attacker public attacker;

    function run() public returns (Shop, Attacker){

        vm.startBroadcast();
        
        shop = Shop(0xAe9AD63795bB54A01dD3f5De7a2E79919f6Ee8D3);
        attacker = new Attacker(shop);
        
        vm.stopBroadcast();

        return (shop, attacker);
    }
}

