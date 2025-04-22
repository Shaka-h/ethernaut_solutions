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

        coinFlip = new CoinFlip();
        guess = new Guess(coinFlip);
        
        vm.stopBroadcast();

        return(coinFlip, guess);
    }
}
