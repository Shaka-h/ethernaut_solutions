// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Delegate} from "../src/Delegate.sol";
import {Preservation} from "../src/Preservation.sol";
import {LibraryContract} from "../src/Preservation.sol";

contract DeployScript is Script {
    Delegate intermediate;
    LibraryContract libraryContract1;
    LibraryContract libraryContract2;
    Preservation preservation;

    function run() external returns (Delegate, Preservation) {
        vm.startBroadcast();

        libraryContract1 = new LibraryContract();
        libraryContract2 = new LibraryContract();


        preservation = new Preservation(address(libraryContract1), address(libraryContract2));
        
        intermediate = new Delegate(preservation);
        // intermediate = new Delegate(Preservation(0x963ACd08563D83A75d58741254d394800A7DA4A7));

        vm.stopBroadcast();

        return (intermediate, preservation);
    }

    function attack() external returns (Delegate, Preservation) {
        vm.startBroadcast();

        libraryContract1 = new LibraryContract();
        libraryContract2 = new LibraryContract();


        preservation = new Preservation(address(libraryContract1), address(libraryContract2));
        
        // intermediate = new Delegate(preservation);
        intermediate = new Delegate(Preservation(0x963ACd08563D83A75d58741254d394800A7DA4A7));

        vm.stopBroadcast();

        return (intermediate, preservation);
    }
}
