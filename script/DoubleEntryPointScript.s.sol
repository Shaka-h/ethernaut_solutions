// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {AlertBot} from "../src/AlertBot.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IDoubleEntryPoint {
    function cryptoVault() external view returns (address);

    function forta() external view returns (IForta);
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;
}

contract DoubleEntryPointScript is Script {
    IDoubleEntryPoint doubleEntryPoint =
        IDoubleEntryPoint(0x2053CaE6F204145C5e40b4F4A3757d60B28a00E4); 

    function run() external {
        vm.startBroadcast();

        address cryptoVault = doubleEntryPoint.cryptoVault();
        AlertBot alertBot = new AlertBot(cryptoVault);
        doubleEntryPoint.forta().setDetectionBot(address(alertBot));

        vm.stopBroadcast();
    }
}