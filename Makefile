-include .env

test :; forge test

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

zk-anvil :; npx zksync-cli dev start

# install :; forge install openzeppelin/openzeppelin-contracts@v4.8.3

install :; forge install OpenZeppelin/openzeppelin-foundry-upgrades & forge install OpenZeppelin/openzeppelin-contracts@v4.9.6 & forge install OpenZeppelin/openzeppelin-contracts-upgradeable@v4.9.6

deploy:
	@forge script script/deploy.s.sol:Deploy $(NETWORK_ARGS)

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy-sepolia:
	@forge script script/DeployScript.s.sol:DeployScript $(NETWORK_ARGS)

deploy-sepolia-network:
	forge script script/DeployScript.s.sol:DeployScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-denial:
	forge script script/Attack.s.sol:DenialScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-double-entry:
	forge script script/DoubleEntryPointScript.s.sol:DoubleEntryPointScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-GateKeeper-Two:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-King:
	forge script script/attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Naught-Coin:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Recovery:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Switch:
	forge script script/Switch.s.sol:SwitchScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-elevator:
	forge script script/SetTopScript.s.sol:SetTopScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-puzzle:
	forge script script/Puzzle.s.sol:PuzzleScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Dex:
	forge script script/attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-GoodSamaritan:
	forge script script/GudSamaritanScript.s.sol:GudSamaritanScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-MagicNum:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Preservation:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Reentrancy:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-alien-code:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Force:
	forge script script/attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-shop:
	forge script script/attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Dex-Two:
	forge script script/DexTwoScript.s.sol:DexTwoScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-GateKeeperThree:
	forge script script/Attack.s.sol:AttackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-HigherOrder:
	forge script script/HigherOrder.s.sol:HigherOrderScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-sepolia-network:
	forge script script/Attack.s.sol:PrivacySolution --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-MotorBike:
	forge script script/Attack.s.sol:PrivacySolution --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Stake:
	forge script script/StakeScript.s.sol:StakeScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-CoinFlip:
	forge script script/Guess.s.sol:GuessScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

attack-Telephone:
	forge script script/Guess.s.sol:GuessScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -
	
attack-Fallback:
	forge script script/Fallback.s.sol:FallbackScript --rpc-url $(SEPOLIA_RPC_URL) --account defaultKey --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv