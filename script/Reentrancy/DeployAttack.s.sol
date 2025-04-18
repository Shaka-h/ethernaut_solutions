// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {ReentranceAttack} from "../src/ReentranceAttack.sol";

contract DeployAttackScript is Script {
    Reentrance public reentrance;
    ReentranceAttack public reentranceAttack;

    function run() public returns (Reentrance, ReentranceAttack){
        reentrance = new Reentrance();
        reentranceAttack = new ReentranceAttack(reentrance);
        return (reentrance, reentranceAttack);
    }
}
