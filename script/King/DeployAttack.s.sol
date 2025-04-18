// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ForeverKing} from "../src/ForeverKing.sol";
import {King} from "../src/King.sol";

contract DeployAttackScript is Script {
    ForeverKing public foreverKing;
    King public king;

    function run() public returns(ForeverKing, King) {
        vm.startBroadcast();
        
        king = King(payable(0xD5a94B40E48aF9A0d267E42D982c1d972BB2744c));
        // king = new King();
        foreverKing = new ForeverKing(king);
        
        vm.stopBroadcast();

        return (foreverKing, king);
    }
}
