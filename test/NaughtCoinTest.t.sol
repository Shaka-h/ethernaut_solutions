// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {NaughtCoin} from "../src/Naught_coin.sol";
import {Attack} from "../src/Attack.sol";
import {DeployScript} from "../script/DeployScript.s.sol";

contract NaughtCoinTest is Test {
    NaughtCoin public naughtCoin;
    Attack public attack;
    DeployScript public deployScript;
    address player = makeAddr("player");

    function setUp() public {
        
        vm.startBroadcast();

        naughtCoin = new NaughtCoin(player);
        
        attack = new Attack(naughtCoin);
        // intermediate = new Attack(NaughtCoin(0x0fcd2a334573931dC851C28A709Bcc888428C41f));

        vm.stopBroadcast();
    }

    function testGasRequired() public {

        vm.startPrank(player);

        // Approve the attacker contract to spend the player's tokens
        naughtCoin.approve(address(attack), naughtCoin.balanceOf(player));

        // Now call attack which uses transferFrom(player, attack, ...)
        attack.attack();

        vm.stopPrank();

        console2.log("naughtCoin.balanceOf(player)", naughtCoin.balanceOf(player));
        console2.log("naughtCoin.balanceOf(attack)", naughtCoin.balanceOf(address(attack)));
    }

}
