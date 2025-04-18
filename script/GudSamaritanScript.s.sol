// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {GudSama} from "../src/GoodSamaritan/GudSama.sol";
import { GoodSamaritan, Coin, Wallet} from "../src/GoodSamaritan/GoodSamaritan.sol";

contract GudSamaritanScript is Script {
    GudSama public gudSama;
    GoodSamaritan goodSamaritan;
    Coin coin;
    Wallet wallet;

    function setUp() public {
        
    }

    function run() public {
        vm.startBroadcast();

        goodSamaritan = GoodSamaritan(0xe6e4eaEC450d81b933e0c818e72ff8AB0c6B719B);
        coin = goodSamaritan.coin();
        wallet = goodSamaritan.wallet();

        console.log("coin.balances(address(wallet))", coin.balances(address(wallet)));

        gudSama = new GudSama(goodSamaritan, coin, wallet);

        gudSama.robTheSama();

        vm.stopBroadcast();
    }
}
