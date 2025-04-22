The goal of this level is for you to hack the basic token contract below.

You are given 20 tokens to start with and you will beat the level if you somehow manage to get your hands on any additional tokens. Preferably a very large amount of tokens.

  Things that might help:

What is an odometer?

Overflows are very common in solidity and must be checked for with control statements such as:

if(a + c > a) {
  a = a + c;
}
An easier alternative is to use OpenZeppelin's SafeMath library that automatically checks for overflows in all the mathematical operators. The resulting code looks like this:

a = a.add(c);
If there is an overflow, the code will revert.

### **Solution**

An odometer or odograph is an instrument used for measuring the distance traveled by a vehicle, such as a bicycle or car.

To succeed at this level, we have to understand the concept of underflow and overflow in solidity. All variables have a maximum value that they can hold, and if you try to add a value that exceeds this maximum, the variable will overflow and start from 0.

And since we are using mostly unsigned integers (uint) in solidity, variables also have a minimum value (0), and if you try to subtract a value that is greater than the current value, the variable will underflow and start from the maximum value.

`Solidity's unsigned integers have a fixed range of values they can represent. An overflow occurs when a calculation exceeds an unsigned integer's maximum value, and underflow happens when a calculation drops below an unsigned integer's minimum value (which is 0 for unsigned integers).`

``` js
pragma solidity ^0.6.0;

contract Example {
    uint8 public minValue = 0;
    uint8 public maxValue = 255;

    function underflow() public {
        // 0 - 1 = 255 (Underflow)
        minValue--;
    }

    function overflow() public {
        // 255 + 1 = 0 (Overflow)
        maxValue++;
    }
}
```

``` js
require(balances[msg.sender] - _value >= 0); // Passed since the attack contract (msg.sender) has no balance
// 0 - 1 = 2^256 - 1
balances[msg.sender] -= _value; // balances[msg.sender] = 2^256 - 1;
```

### Takeaway

- Always use a recent version of Solidity (^0.8.0) to benefit from native overflow and underflow checks.
- If you need to interact with a contract using a solidity version older than 0.8.0, always check that the contract is using a SafeMath library or equivalent.
