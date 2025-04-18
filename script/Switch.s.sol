// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Switch} from "../src/Switch.sol";

contract SwitchScript is Script {
    Switch public switchContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // switchContract = new Switch();
        switchContract = Switch(0x21FA718ADa830718bd9cb2a4d3eda55cF351C4Df);

        bytes
            memory data = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000020606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";

        (bool success, ) = address(switchContract).call(data);

        require(success, "Toogle failed!");

        console.log("Switch on ", switchContract.switchOn());

        vm.stopBroadcast();
    }
}
