In Ethereum, `tx.origin` is a global variable that refers to the **original external account (EOA)** that initiated the transaction. It is a part of the Ethereum Virtual Machine (EVM) and can be accessed by smart contracts during the execution of a transaction.

### **Key Points About `tx.origin`**:
1. **The Origin of the Transaction:**
   - `tx.origin` always points to the **original sender** of the transaction, regardless of how many contracts the transaction passes through.
   - If an externally owned account (EOA) initiates a transaction, `tx.origin` will be that address.
   - If a smart contract (Contract A) calls another contract (Contract B), and Contract B further calls another contract (Contract C), `tx.origin` will still be the address of the original EOA that initiated the transaction, not the intermediate contracts.

2. **Contrast with `msg.sender`:**
   - `msg.sender` is the address of the immediate caller of the current function. In contrast, `tx.origin` is the original initiator.
   - For example:
     - If EOA `0x123` sends a transaction to contract A, and A calls contract B, `msg.sender` in contract B will be contract A's address, but `tx.origin` will still be `0x123` (the original EOA).
   
3. **Security Concerns:**
   - Using `tx.origin` for authentication is **considered risky** because it can lead to vulnerabilities like **reentrancy attacks** or **unauthorized access**.
   - For example, if contract A calls contract B, and contract B checks `tx.origin` for some permission logic, a malicious contract could exploit this behavior.
   - Therefore, it's recommended to use `msg.sender` for permission checks and avoid relying on `tx.origin` in security-sensitive operations.

### **Example Usage:**

```solidity
pragma solidity ^0.8.0;

contract Example {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function that checks if the transaction was initiated by the contract owner
    function isOwner() public view returns (bool) {
        return tx.origin == owner; // Uses tx.origin, which is the original sender
    }
}
```

In this example:
- If the contract `Example` is called by another contract, `tx.origin` will still refer to the original external account that initiated the transaction, not the address of the calling contract.

### **When to Use `tx.origin`:**
`tx.origin` is generally only used in very specific cases where it’s necessary to know the origin of a transaction, and should not be used for things like permission checks or security-sensitive logic. Instead, you should rely on `msg.sender` in most cases to ensure more predictable and secure behavior.

### **Conclusion:**
- `tx.origin` returns the original sender of the transaction.
- **Avoid using it for authorization or critical logic** due to its potential for misuse and security vulnerabilities.
- **Use `msg.sender`** for transaction context and user-specific actions.

### **Solution:**
Write another contract that calls the deployed Telephone contract and passes in the new owner's address to check `tx.origin != msg.sender`

``` js
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface ITelephone {
  function changeOwner(address _owner) external;
}

contract IntermediateContract {
  function changeOwner(address _addr) public {
    ITelephone(_addr).changeOwner(msg.sender);
  }
}
```