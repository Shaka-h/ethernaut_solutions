// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Shop} from "../src/shop/Shop.sol";
import {Attacker} from "../src/shop/ShopAttacker.sol";
import {DeployAttackScript} from "../script/shop/Deploy.s.sol";
import {Test, console} from "forge-std/Test.sol";

// name contract diffeernt to Buy
contract BuyAttack is Test{
    Shop public shop;
    Attacker public attacker;

    function setUp() public {
        DeployAttackScript deployAttackScript = new DeployAttackScript();
        (shop, attacker) = deployAttackScript.run();
    }

    function testBuyAttack() public {
        vm.prank(address(attacker));
        shop.buy();

        assertEq(shop.price(), 0);
        assertEq(shop.isSold(), true);
    }
}
