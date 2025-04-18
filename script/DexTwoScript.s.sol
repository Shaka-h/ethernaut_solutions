// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DexTwo, SwappableTokenTwo} from "../src/DexTwo.sol";

contract DexTwoScript is Script {
    SwappableTokenTwo public dumbToken;
    DexTwo dexTwo = DexTwo(0xF26e2Ae614CE06fA1f9ef2906a5810F6250a7b4B);
    address myAddress = 0x5134FCA2Ce708AEf8672ffB6561288ee81E30543;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        dumbToken = new SwappableTokenTwo(address(dexTwo), "dex", "DEX", 400);
        // dexTwo.add_liquidity(address(dumbToken), 50);
        dumbToken.transfer(address(dexTwo), 100);
        // dumbToken.transfer(myAddress, 200);
        dumbToken.approve(address(dexTwo), 300);
        dexTwo.approve(address(dexTwo), type(uint256).max);
        dexTwo.swap(address(dumbToken), dexTwo.token1(), 100);
        dexTwo.swap(address(dumbToken), dexTwo.token2(), 200);

        vm.stopBroadcast();
    }
}
