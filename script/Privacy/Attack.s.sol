// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PrivacySolution is Script {

    Privacy public privacyInstance = Privacy(0xdfC349F22318BB2B42e08c638D7DcC81422f73C0);

    function run() external {

        vm.startBroadcast();
        bytes32 key = 0xc56a8060e095721d584ece2972f5c524abbaa589528706daeaef4dd306558667;
        console.log("Before: ", privacyInstance.locked());
        privacyInstance.unlock(bytes16(key));
        console.log("After: ", privacyInstance.locked());
        vm.stopBroadcast();

    }
}