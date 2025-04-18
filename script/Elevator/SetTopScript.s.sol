// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Delegate} from "../src/Delegate.sol";
import {Elevator} from "../src/Elevator.sol";

contract SetTopScript is Script {
    Delegate public delegate;
    Elevator public elevator;

    function setUp() public {
        
        address elevatorContractAddress = 0x44Ad4926bb69F77b1642F054F763116ACf43FA7e;
        address delegateContractAddress = 0x1601911611dB12F94923Bec6D93180449102B7EB;

        delegate = Delegate(delegateContractAddress);
        elevator = Elevator(elevatorContractAddress);
    }

    function run() public {
        
        vm.startBroadcast(); 
        
        console2.log("Elevator.top =", elevator.top());
        console2.log("Elevator.floor =", elevator.floor());

        delegate.setTop(1);

        console2.log("Elevator.top =", elevator.top());
        console2.log("Elevator.floor =", elevator.floor());

        vm.stopBroadcast();
   
    }
}
