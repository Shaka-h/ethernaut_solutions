// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/MagicNum.sol";

contract AttackScript is Script {

// 602a60805260206080f3 + 600a600c600039600a6000f3
// 600a600c600039600a6000f3602a60505260206050f3

    MagicNum solverContract = MagicNum(0x71de31E60B3576B923A4ED13A9c60B9759c4B960);
    
    function run() external{
        vm.startBroadcast();
        bytes memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solver;

        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }
        solverContract.setSolver(solver);
        vm.stopBroadcast();
    }
}

