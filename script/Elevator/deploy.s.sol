// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Delegate} from "../src/Delegate.sol";
import {Elevator} from "../src/Elevator.sol";

contract Deploy is Script {
    Delegate public delegate;
    Elevator public elevator;

    function run() public returns (Elevator, Delegate) {
        vm.startBroadcast();

        elevator = Elevator(0x44Ad4926bb69F77b1642F054F763116ACf43FA7e);
        delegate = new Delegate(elevator);

        vm.stopBroadcast();

        return(elevator, delegate);
    }
}
