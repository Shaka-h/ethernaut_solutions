// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, stdError} from "forge-std/Test.sol";
import {DenialAttack} from "../src/Denial/DenialAttack.sol";
import {Denial} from "../src/Denial/Denial.sol";

contract DenialTest is Test {
    Denial public denial;
    DenialAttack public denialAttack;

    function setUp() public {
        denial = new Denial();
        denialAttack = new DenialAttack();
        vm.deal(address(denial), 1 ether);
    }

    function test_DenialAttack() public {
        denial.setWithdrawPartner(address(denialAttack));
        // vm.expectRevert(stdError.EvmError);
        denial.withdraw();
    }
}
