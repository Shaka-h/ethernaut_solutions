// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Guess} from "../../src/Coinflip/Guess.sol";
import {CoinFlip} from "../../src/Coinflip/CoinFlip.sol";

contract DeployGuess is Script {
    Guess public guess;
    CoinFlip coinFlip;

    function run() public returns (CoinFlip, Guess) {
        vm.startBroadcast();

        coinFlip = CoinFlip(0x2341a282a81482Add89F86C802a93FB3D0aB7366);
        guess = new Guess(coinFlip);
        
        vm.stopBroadcast();

        return(coinFlip, guess);
    }
}
