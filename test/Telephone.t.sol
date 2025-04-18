// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Test, console2} from "forge-std/Test.sol";
import {Telephone} from "../src/Telephone.sol";
import {IntermediateContract} from "../src/IntermediateContract.sol";

// Mock Telephone contract to simulate ownership change
contract MockTelephone is ITelephone {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function changeOwner(address _owner) external override {
        owner = _owner;
    }
}

contract IntermediateTest is Test {
    IntermediateContract intermediate;
    MockTelephone mockTelephone;
    address attacker;

    function setUp() public {
        // Deploy Mock Telephone contract
        mockTelephone = new MockTelephone();
        console2.log("MockTelephone deployed at:", address(mockTelephone));

        // Deploy Intermediate contract
        intermediate = new IntermediateContract();
        console2.log("IntermediateContract deployed at:", address(intermediate));

        // Create an attacker address
        attacker = address(1337);
    }

    function test_ChangeOwner() public {
        // Verify initial owner
        assertEq(mockTelephone.owner(), address(this), "Initial owner should be this contract");

        // Prank as the attacker
        vm.prank(attacker);
        intermediate.changeOwner(address(mockTelephone));

        // Verify ownership has changed
        assertEq(mockTelephone.owner(), attacker, "Owner should be changed to attacker");
    }
}
