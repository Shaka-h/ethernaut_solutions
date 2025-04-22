# Hack
Unlock the vault to pass the level

## The hack

It requires an understanding of how storage works in solidity (usage of 32-byte sized slots) and the JSON RPC function `eth_getStorageAt`.

### Storage (Static types)

EVM stores data in 32-byte slots. The first state variable is stored at slot 0. If there are enough bytes left, the next variable is also stored at slot 0, otherwise at slot 1, and so on.

> NOTE: Dynamic types like arrays and strings are different and don't work the same way. But this is for another level...

In the Vault contract, `locked` is a boolean and uses 1 bytes. The slot 0 has 31 bytes of unused storage. `password` is a bytes32 and uses 32 bytes. Since it doesn't fit in the 31 bytes left in slot 0, it is stored at slot 1.

### Reading the storage

In Foundry, you can make use of `cast` to achieve the same result:

```bash
cast storage <contractAddress> 1 --rpc-url sepolia
```

## Solution

Since we know that the password is stored at slot 1, we can read the storage at that slot to find the password and then call the `unlock` function with the password to complete the level.

### In the browser console:

```javascript
    function run() public {
        vault = Vault(0x7e73c88caf2EB9b1B70201F9d12671A5D11a7d3A);

        vm.startBroadcast();

        bytes32 passwordSlot = vm.load(address(vault), bytes32(uint256(1)));

        vault.unlock(passwordSlot);

        console.log("Vault is locked? ", vault.locked());

        vm.stopBroadcast();
    }
```

### With Foundry using `cast`:

```bash
cast storage <contractAddress> 1 --rpc-url sepolia
```

## Takeaway

- The `private` keyword means that the data can only be accessed by the contract itself, not that it is hidden from the world.
- Nothing is private on the blockchain. Everything is public and can be read by anyone.
