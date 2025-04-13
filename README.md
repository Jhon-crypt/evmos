# Universe Chain Documentation

This guide provides comprehensive instructions for running and interacting with Universe Chain, a Layer 2 Proof of Authority (PoA) blockchain with Ethereum Virtual Machine (EVM) compatibility.

## Table of Contents

1. [About Universe Chain](#about-universe-chain)
2. [Setup and Installation](#setup-and-installation)
3. [Running the Blockchain](#running-the-blockchain)
4. [Wallet Management](#wallet-management)
5. [Sending Transactions](#sending-transactions)
6. [Smart Contract Deployment](#smart-contract-deployment)
7. [Node Monitoring](#node-monitoring)
8. [Explorer Integration](#explorer-integration)
9. [API Documentation and Tools](#api-documentation-and-tools)
10. [Troubleshooting](#troubleshooting)

## About Universe Chain

Universe Chain is a Layer 2 Proof of Authority (PoA) blockchain built on top of Evmos technology, featuring:

- **Chain Name**: Universe Chain (Mainnet and Testnet variants)
- **Token Name**: UCC (Mainnet) and tUCC (Testnet)
- **Total Supply**: 18,000,000 tokens
- **Gas Fee**: 0.00001 UCC per transaction (automatic pricing for smart contracts)
- **Address Format**: All addresses start with "ucc" prefix
- **Consensus**: Proof of Authority (PoA) for faster and more efficient block production
- **EVM Compatibility**: Full support for Ethereum smart contracts and tooling

## Setup and Installation

The Universe Chain is now deployed directly on the host system with systemd services for better reliability and management.

### Prerequisites

- Ubuntu 20.04 LTS or later
- Git and build essentials
- Basic understanding of blockchain operations
- Terminal/command-line interface familiarity

### Quick Start

We provide a setup script that handles the entire installation process:

```bash
# Make the script executable
chmod +x /root/ucc-chain-setup.sh

# Run the setup script
./ucc-chain-setup.sh
```

The setup script will:
1. Build a customized version of Evmos with UCC prefixes
2. Set up your chosen network (Mainnet, Testnet, or both)
3. Configure the blockchain with proper parameters
4. Start the blockchain as a systemd service

### Explorer Integration

To integrate with the Next.js explorer, use the endpoints displayed at the end of the setup process.

## Running the Blockchain

The script will set up the blockchain as a systemd service, making it easier to manage:

### Checking Service Status

```bash
# For Testnet
systemctl status ucc-testnet

# For Mainnet
systemctl status ucc-mainnet
```

### Starting/Stopping the Service

```bash
# Start Testnet
systemctl start ucc-testnet

# Stop Testnet
systemctl stop ucc-testnet

# Start Mainnet
systemctl start ucc-mainnet

# Stop Mainnet
systemctl stop ucc-mainnet
```

### Viewing Logs

```bash
# View Testnet logs
journalctl -u ucc-testnet -f

# View Mainnet logs
journalctl -u ucc-mainnet -f
```

## Wallet Management

### Creating a New Wallet

```bash
# For Testnet
/opt/universe-chain/bin/uccd keys add <wallet-name> --keyring-backend=test --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd keys add <wallet-name> --keyring-backend=test --home=/root/.universe-mainnet
```

This command will:
- Generate a new private/public key pair
- Display and store the address (starting with "ucc")
- Provide a recovery mnemonic phrase (SAVE THIS SECURELY)

Example output:
```
- name: myWallet
  type: local
  address: ucc18d45zvw6c7p9qestpn5v7nk4gxj6k2q34k9l3a
  pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"AmB4AY4D4D4BnSwxUP8d5EQU8mBVkHzQzNyPRQjzqs2e"}'
  mnemonic: ""

**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

pride solution crystal horse speak advance small power recycle fan govern brick coast dwarf weapon almost eternal bleak broccoli inject media guess about
```

### Recovering a Wallet Using Mnemonic

```bash
# For Testnet
echo 'your mnemonic phrase here' | /opt/universe-chain/bin/uccd keys add <wallet-name> --recover --keyring-backend=test --home=/root/.universe-testnet

# For Mainnet
echo 'your mnemonic phrase here' | /opt/universe-chain/bin/uccd keys add <wallet-name> --recover --keyring-backend=test --home=/root/.universe-mainnet
```

### Listing Wallets

```bash
# For Testnet
/opt/universe-chain/bin/uccd keys list --keyring-backend=test --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd keys list --keyring-backend=test --home=/root/.universe-mainnet
```

### Getting Account Balance

```bash
# For Testnet
/opt/universe-chain/bin/uccd query bank balances <address> --chain-id=universe_9000-1 --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd query bank balances <address> --chain-id=universe_1-1 --home=/root/.universe-mainnet
```

### Funding a New Account

To fund a new account from the validator account (which holds the initial supply):

```bash
# For Testnet
/opt/universe-chain/bin/uccd tx bank send validator <recipient-address> 1000000000000000000atucc --chain-id=universe_9000-1 --gas=auto --gas-adjustment=1.5 --gas-prices=10000000000000atucc --keyring-backend=test -y --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd tx bank send validator <recipient-address> 1000000000000000000aucc --chain-id=universe_1-1 --gas=auto --gas-adjustment=1.5 --gas-prices=10000000000000aucc --keyring-backend=test -y --home=/root/.universe-mainnet
```

Note: 1 UCC/tUCC = 10^18 aucc/atucc (atto-UCC/tUCC is the smallest denomination)

## Sending Transactions

### Cosmos SDK Transactions

```bash
# For Testnet
/opt/universe-chain/bin/uccd tx bank send <sender-wallet-name> <recipient-address> <amount>atucc --chain-id=universe_9000-1 --gas=auto --gas-adjustment=1.5 --gas-prices=10000000000000atucc --keyring-backend=test -y --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd tx bank send <sender-wallet-name> <recipient-address> <amount>aucc --chain-id=universe_1-1 --gas=auto --gas-adjustment=1.5 --gas-prices=10000000000000aucc --keyring-backend=test -y --home=/root/.universe-mainnet
```

Example:
```bash
# Send 5 tUCC tokens on Testnet
/opt/universe-chain/bin/uccd tx bank send myWallet ucc12345abcde... 5000000000000000000atucc --chain-id=universe_9000-1 --gas=auto --gas-adjustment=1.5 --gas-prices=10000000000000atucc --keyring-backend=test -y --home=/root/.universe-testnet
```

### Ethereum Transactions

You can use tools like Web3.js, ethers.js, or MetaMask to interact with the Ethereum JSON-RPC endpoint at `http://145.223.80.193:8545`.

To add Universe Chain to MetaMask:
1. Open MetaMask
2. Go to Networks > Add Network
3. Enter the following details for Testnet:
   - Network Name: Universe Chain Testnet
   - RPC URL: http://145.223.80.193:8545
   - Chain ID: 9000
   - Currency Symbol: tUCC
   - Block Explorer URL: (leave blank for now)

For Mainnet, use:
   - Network Name: Universe Chain Mainnet
   - RPC URL: http://145.223.80.193:8545
   - Chain ID: 1
   - Currency Symbol: UCC
   - Block Explorer URL: (leave blank for now)

## Smart Contract Deployment

### Using Remix

1. Go to [Remix IDE](https://remix.ethereum.org/)
2. Create or import your smart contract
3. Compile the contract
4. Go to "Deploy & Run Transactions"
5. Select "Injected Web3" as the environment (ensure MetaMask is connected to Universe Chain)
6. Deploy your contract

The gas fee for smart contract execution is calculated automatically.

### Using Hardhat

1. Set up a Hardhat project
2. Add Universe Chain to your network configuration:

```javascript
// hardhat.config.js
module.exports = {
  networks: {
    universeTestnet: {
      url: "http://145.223.80.193:8545",
      chainId: 9000,
      accounts: ["your-private-key"]
    },
    universeMainnet: {
      url: "http://145.223.80.193:8545",
      chainId: 1,
      accounts: ["your-private-key"]
    }
  }
};
```

3. Deploy using:
```bash
# For Testnet
npx hardhat run scripts/deploy.js --network universeTestnet

# For Mainnet
npx hardhat run scripts/deploy.js --network universeMainnet
```

## Node Monitoring

### Checking Node Status

```bash
# For Testnet
curl http://localhost:26657/status

# For Mainnet
curl http://localhost:26657/status
```

### Checking Latest Block

```bash
# For Testnet
curl http://localhost:26657/block

# For Mainnet
curl http://localhost:26657/block
```

### Checking Ethereum Block Number

```bash
# Get the current Ethereum block number
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  -H "Content-Type: application/json" http://localhost:8545
```

### Querying Blockchain Parameters

```bash
# For Testnet
/opt/universe-chain/bin/uccd query staking params --chain-id=universe_9000-1 --home=/root/.universe-testnet

# For Mainnet
/opt/universe-chain/bin/uccd query staking params --chain-id=universe_1-1 --home=/root/.universe-mainnet
```

## Explorer Integration

The Next.js explorer frontend can be integrated with Universe Chain using the endpoints displayed after setup:

### Available API Endpoints

- Cosmos REST API: http://145.223.80.193:1317
- Ethereum JSON-RPC: http://145.223.80.193:8545
- Ethereum WebSocket: ws://145.223.80.193:8546
- Tendermint RPC: http://145.223.80.193:26657
- gRPC: 145.223.80.193:9090

### Integration Steps

1. Configure your Next.js explorer to use these endpoints
2. Ensure CORS headers are properly configured (already done in the Universe Chain setup)
3. Test the connection to the blockchain

## API Documentation and Tools

### Accessing Swagger Documentation

Universe Chain provides Swagger documentation for the Cosmos REST API, which can be accessed at:

```
http://<your-server-ip>:1317/swagger/
```

For example, with the default setup:
```
http://145.223.80.193:1317/swagger/
```

The Swagger UI allows you to browse and test all available REST API endpoints with a user-friendly interface.

### Other API Endpoints

#### Cosmos REST API Query Examples

1. Get chain information:
```bash
curl http://145.223.80.193:1317/cosmos/base/tendermint/v1beta1/node_info
```

2. Query account balances:
```bash
curl http://145.223.80.193:1317/cosmos/bank/v1beta1/balances/<account-address>
```

3. Get validator information:
```bash
curl http://145.223.80.193:1317/cosmos/staking/v1beta1/validators
```

#### Tendermint RPC Examples

1. Get network status:
```bash
curl http://145.223.80.193:26657/status
```

2. Get network information:
```bash
curl http://145.223.80.193:26657/net_info
```

3. Get consensus state:
```bash
curl http://145.223.80.193:26657/consensus_state
```

4. Get validators:
```bash
curl http://145.223.80.193:26657/validators
```

#### Ethereum JSON-RPC Examples

1. Get network version:
```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"net_version","params":[],"id":1}' -H "Content-Type: application/json" http://145.223.80.193:8545
```

2. Get accounts:
```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}' -H "Content-Type: application/json" http://145.223.80.193:8545
```

3. Get gas price:
```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_gasPrice","params":[],"id":1}' -H "Content-Type: application/json" http://145.223.80.193:8545
```

### API Libraries

For programmatic access, you can use these libraries:

1. **JavaScript/TypeScript**:
   - CosmJS for Cosmos transactions: https://github.com/cosmos/cosmjs
   - Ethers.js for Ethereum transactions: https://docs.ethers.org/

2. **Python**:
   - Cosmpy for Cosmos transactions: https://github.com/fetchai/cosmpy
   - Web3.py for Ethereum transactions: https://web3py.readthedocs.io/

## Troubleshooting

### Service Issues

If the service stops or experiences issues:

```bash
# For Testnet
# Check service status
systemctl status ucc-testnet

# Check service logs
journalctl -u ucc-testnet -f -n 100

# Restart the service
systemctl restart ucc-testnet

# For Mainnet
# Check service status
systemctl status ucc-mainnet

# Check service logs
journalctl -u ucc-mainnet -f -n 100

# Restart the service
systemctl restart ucc-mainnet
```

### Build Issues

If you encounter issues during the build process:

1. Ensure you have all necessary dependencies installed:
```bash
apt-get update && apt-get install -y git make gcc g++ curl jq
```

2. Check disk space to ensure you have enough space for the build:
```bash
df -h
```

3. Try cleaning the build environment and running the setup script again:
```bash
rm -rf /opt/universe-chain
./ucc-chain-setup.sh
```

### API Connection Issues

If you cannot connect to the API endpoints:

1. Verify the service is running: `systemctl status ucc-testnet` or `systemctl status ucc-mainnet`
2. Check if the ports are listening: `netstat -tulpn | grep "26657\|8545\|1317\|9090"`
3. Ensure no firewall is blocking the connections: `ufw status`
4. Make sure your server's firewall allows external connections to the required ports

---

For additional support or features, please refer to the official documentation or open an issue on our GitHub repository. 


/opt/universe-chain/bin/uccd debug addr 0x6753DEFa1fa1380b5e272468C8739E8772095ec2 | cat
