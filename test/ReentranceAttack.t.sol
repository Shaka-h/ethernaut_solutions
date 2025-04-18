// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {Reentrance} from "../src/Reentrancy/Reentrance.sol";
import {ReentranceAttack} from "../src/Reentrancy/ReentranceAttack.sol";
import {DeployAttackScript} from "../script/Reentrancy/DeployAttack.s.sol";
import {Test, console} from "forge-std/Test.sol";

// Attacker calles victim and victim calls external contract which begina a loop between external and victim

contract ReentranceAttackTest is Test{
    Reentrance reentrance; 
    ReentranceAttack reentranceAttack;

    function setUp() public {
        DeployAttackScript deployAttackScript = new DeployAttackScript();
        (reentrance, reentranceAttack) = deployAttackScript.run();
    }

    function testReentrancyAttack() public {
        vm.deal(address(reentrance), 5 ether);
        vm.deal(address(reentranceAttack), 1 ether);

        uint256 startingBalanceVictim = address(reentrance).balance;
        uint256 startingBalanceAttacker = address(reentranceAttack).balance;

        vm.prank(address(reentranceAttack));
        reentranceAttack.takeEverything{value: 1 ether}();

        uint256 endingBalanceVictim = address(reentrance).balance;
        uint256 endingBalanceAttacker = address(reentranceAttack).balance;

        console.log("startingBalanceVictim", startingBalanceVictim);
        console.log("startingBalanceAttacker", startingBalanceAttacker);
        console.log("endingBalanceVictim", endingBalanceVictim);
        console.log("endingBalanceAttacker", endingBalanceAttacker);
        console.log("Victim", address(reentrance));
        console.log("Attacker", address(reentranceAttack));
        // console.log("Attacker", reentrance.balanceOf(address(reentrance)));
        console.log("Attacker", reentrance.balanceOf(address(reentranceAttack)));


    }
}
