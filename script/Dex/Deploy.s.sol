// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Dex} from "../src/Dex.sol";
import {SwappableToken} from "../src/Dex.sol";

contract DeployAttackScript is Script {
    Dex public dex;
    SwappableToken public swappableToken1;
    SwappableToken public swappableToken2;

    function run() public returns (Dex, SwappableToken, SwappableToken) {
        vm.startBroadcast();

        dex = new Dex();
        swappableToken1 = new SwappableToken(address(dex), "token1", "TK1", 100);
        swappableToken2 = new SwappableToken(address(dex), "token2", "TK2", 100);

        vm.stopBroadcast();

        return(dex, swappableToken1, swappableToken2);
    }
}
 