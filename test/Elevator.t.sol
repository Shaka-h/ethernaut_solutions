// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Delegate} from "../src/Elevator/Delegate.sol";
import {Elevator} from "../src/Elevator/Elevator.sol";

contract DelegateTest is Test {
    Delegate public delegate;
    Elevator public elevator;

    function setUp() public {
        elevator = new Elevator();
        delegate = new Delegate(elevator);
    }


    function testSetTopViaDelegate() public {
        // Initially, top should be false
        assertEq(elevator.top(), false);

        // Call setTop with a dummy floor value
        delegate.setTop(1);

        // Now, top should be true if the exploit worked
        assertEq(elevator.top(), true);
    }

}
