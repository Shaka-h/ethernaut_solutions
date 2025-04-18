// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract SolverTest is Test {
    function testDeploySolver() public {
        bytes memory bytecode = hex"602a60005260206000f3";
        address solver = makeAddr("solver");
        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        // Check if it returns 42
        (bool success, bytes memory data) = solver.staticcall("");
        require(success);
        require(abi.decode(data, (uint256)) == 42);
    }
}

