// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";
import {Force} from "../src/Force.sol";

contract DeployAttackScript is Script {
    Attack public attack;
    Force public force;

    function run() public returns(Force, Attack) {
        vm.startBroadcast();
        
        force = Force(0x1063b6289F35f904d8e6E53886f239046E327475);
        // force = new Force();
        attack = new Attack{ value: 100000000000000 wei }(force);
        
        vm.stopBroadcast();

        return (force, attack);
    }
}
