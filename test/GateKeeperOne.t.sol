// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {GatekeeperOne} from "../src/GatekeeperOne/GatekeeperOne.sol";
import {Attack} from "../src/GatekeeperOne/IntermediateContract.sol";
import {DeployScript} from "../script/GatekeeperOne/Intermediate.s.sol";

contract CounterTest is Test {
    GatekeeperOne public gatekeeperOne;
    Attack public intermediateContract;
    DeployScript public deployScript;

    function setUp() public {
        deployScript = new DeployScript();
        (intermediateContract, gatekeeperOne) = deployScript.run();
    }

    function testGasRequired() public {
        // intermediateContract.hack(256);
        
        for (uint256 i = 200; i < 8191; i++) {
            try intermediateContract.hack(i) {
                console2.log("gas", i);
                return;
            } catch {}
        }
        revert("No gas match found!");
    

    }
}
