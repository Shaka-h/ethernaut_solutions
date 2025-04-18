// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract AlienCodex  {
    // address owner from Ownable constructor => slot 0 20bytes
    bool public contact; //1bytes slot 0
    bytes32[] public codex; // bytes32 slot 1

    modifier contacted() {
        assert(contact);
        _;
    }

    function makeContact() public {
        contact = true;
    }

    function record(bytes32 _content) public contacted {
        codex.push(_content);
    }

    function retract() public contacted {
        codex.length--;
    }

    function revise(uint256 i, bytes32 _content) public contacted {
        codex[i] = _content;
    }
}
