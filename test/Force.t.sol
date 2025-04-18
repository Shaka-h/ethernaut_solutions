// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployAttackScript} from "../script/DeployAttack.s.sol";
import {Force} from "../src/Force.sol";
import {Attack} from "../src/Attack.sol";

contract AttackTest is Test {
    DeployAttackScript public deployAttackScript;
    Force public force;
    Attack public attack;

    function setUp() public {
        deployAttackScript = new DeployAttackScript();
        (force, attack ) = deployAttackScript.run();
    }

    function test_ForceReceiveMoney() public {
        assertEq(address(attack).balance, 100000000000000 wei);
        assertEq(address(force).balance, 0 wei);
        attack.sendMoney();
        assertEq(address(force).balance, 100000000000000 wei);
    }

}
