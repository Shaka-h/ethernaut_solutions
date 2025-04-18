// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/Naught_coin.sol";
import {Attack} from "../src/Attack.sol";

contract DeployScript is Script {
    Attack intermediate;
    NaughtCoin naughtCoin;
    address player;

    function run() external returns (Attack, NaughtCoin) {
        vm.startBroadcast();

        naughtCoin = new NaughtCoin(player);
        
        intermediate = new Attack(naughtCoin);
        // intermediate = new Attack(NaughtCoin(0x0fcd2a334573931dC851C28A709Bcc888428C41f));

        vm.stopBroadcast();

        return (intermediate, naughtCoin);
    }
}
