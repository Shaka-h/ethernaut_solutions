// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {GatekeeperTwo} from "../src/GateKeeperTwo/GatekeeperTwo.sol";
import {Attack} from "../src/GateKeeperTwo/Attack.sol";
import {DeployScript} from "../script/GateKeeperTwo/DeployScript.s.sol";

contract CounterTest is Test {
    GatekeeperTwo public gatekeeperTwo;
    Attack public attack;
    DeployScript public deployScript;

    function setUp() public {
        deployScript = new DeployScript();
        (attack, gatekeeperTwo) = deployScript.run();
    }

    function testGasRequired() public {
        attack.attack(gatekeeperTwo);
        // assert( gatekeeperTwo.entrant == tx.origin);
    }
}
