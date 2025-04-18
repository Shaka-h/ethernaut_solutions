// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Privacy} from "../src/Privacy.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployScript is Script {
    Privacy public privacy ;

    function run() public returns (Privacy) {
        vm.startBroadcast();

        bytes32[3] memory data;
        data[0] = bytes32("first_data");
        data[1] = bytes32("second_data");
        data[2] = bytes32("third_data");

        privacy = new Privacy(data);

        vm.stopBroadcast();
        return privacy;
    }


    function unlock(bytes16 key) external {
        console.log("Before: ", privacy.locked());
        privacy.unlock(bytes16(key));
        console.log("After: ", privacy.locked());
    }
    
}
