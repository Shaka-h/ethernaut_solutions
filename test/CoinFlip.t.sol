// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Guess} from "../src/Coinflip/Guess.sol";
import {CoinFlip} from "../src/Coinflip/CoinFlip.sol";


contract CounterTest is Test {
    Guess public guess;
    CoinFlip coinFlip;

    function setUp() public {
        coinFlip = new CoinFlip();
        guess = new Guess(coinFlip);
    }

    function test_Flip_Guess() public {
        for (uint256 i = 0; i < 10; i++) {
            bool outcome = guess.guessOutcome();
            console.log("Attempt:", i + 1, "Success:", outcome);
            assertEq(outcome, true, "Guess failed, streak broken!");
            vm.roll(block.number + 1);
        }
    }

}
