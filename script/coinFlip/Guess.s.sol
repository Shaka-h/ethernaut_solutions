// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Guess} from "../src/Guess.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract GuessScript is Script {
    Guess public guess;
    CoinFlip public coinFlip;
    address player;

    function setUp() public {
        // Replace these with actual deployed contract addresses
        address guessContractAddress = 0x47d19A0cbd382080B4C11e279969fCaf878F7A9b;
        address coinFlipContractAddress = 0x2341a282a81482Add89F86C802a93FB3D0aB7366;

        // address guessContractAddress = 0x34A1D3fff3958843C43aD80F30b94c510645C316;
        // address coinFlipContractAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;

        player = vm.addr(1); // Use an account from Foundry's predefined keys

        guess = Guess(guessContractAddress);
        coinFlip = CoinFlip(coinFlipContractAddress);
    }

    function run() public {
        vm.startBroadcast(player);  // Use `player` for all transactions

        uint256 consecutiveWins = coinFlip.consecutiveWins();

        while (consecutiveWins < 10) {
            guess.guessOutcome();
            consecutiveWins = coinFlip.consecutiveWins();
            console2.log("Consecutive Wins:", consecutiveWins);
        }

        vm.stopBroadcast();

        console2.log("Successfully guessed 10 times in a row!");
    }
}
