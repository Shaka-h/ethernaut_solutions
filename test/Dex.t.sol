// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployAttackScript} from "../script/Dex/Deploy.s.sol";
import {Dex} from "../src/Dex.sol";
import {Dex} from "../src/Dex.sol";
import {SwappableToken} from "../src/Dex.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AttackTest is Test {
    DeployAttackScript public deployAttackScript;
    Dex public dex;
    SwappableToken public swappableToken1;
    SwappableToken public swappableToken2;
    address owner = makeAddr("owner");

    function setUp() public {
        // deployAttackScript = new DeployAttackScript();
        // (dex, swappableToken1, swappableToken2) = deployAttackScript.run();


        vm.startPrank(owner);

        dex = new Dex();
        swappableToken1 = new SwappableToken(address(dex), "token1", "TK1", 100);
        swappableToken2 = new SwappableToken(address(dex), "token2", "TK2", 100);

        console.log("swappableToken1StartBalance", swappableToken1.balanceOf(owner));
        console.log("swappableToken2StartBalance", swappableToken2.balanceOf(owner));

        vm.stopPrank();

    }

    function test_DexAttack() public {
        uint256 swappableToken1StartBalance = address(swappableToken1).balance;
        uint256 swappableToken2StartBalance = address(swappableToken1).balance;
        uint256 swappableToken1EndBalance = address(swappableToken1).balance;
        uint256 swappableToken2EndBalance = address(swappableToken1).balance;

        
        
        vm.startPrank(owner);
        dex.setTokens(address(swappableToken1), address(swappableToken2));

        // swappableToken1.approve(address(dex), 100);
        // swappableToken2.approve(address(dex), 100);
        // dex.approve(address(this), 100);

        IERC20(address(swappableToken1)).transferFrom(address(swappableToken1), address(dex), 100);
        IERC20(address(swappableToken2)).transferFrom(address(swappableToken2), address(dex), 100);

        console.log("swappableToken1StartBalance in dex", dex.balanceOf(address(swappableToken1), address(this)));
        console.log("swappableToken2StartBalance in dex", dex.balanceOf(address(swappableToken2), address(this)));
        
        dex.addLiquidity(address(swappableToken1), 100);
        dex.addLiquidity(address(swappableToken2), 100);

        dex.swap(address(swappableToken1), address(swappableToken2), 10);

        // assertEq((swappableToken1StartBalance * swappableToken2StartBalance), (swappableToken1EndBalance * swappableToken2EndBalance));

    }

}