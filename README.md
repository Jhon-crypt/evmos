
# Universe Chain (Layer 2 Blockchain)

<div align="center">
  <h2>Built on Evmos Technology</h2>
</div>

## About Universe Chain

Universe Chain is a Layer 2 blockchain solution built on Evmos technology, providing a high-performance, EVM-compatible environment with Proof of Authority (PoA) consensus. It's designed to offer fast transaction processing, low gas fees, and seamless integration with Ethereum-based applications.

### Key Features

- **Layer 2 Blockchain with PoA**: Secure and efficient consensus mechanism
- **EVM Compatibility**: Full support for Ethereum smart contracts
- **Custom Address Format**: All addresses start with "UCC" prefix
- **Dual Network Support**: Mainnet (UCC) and Testnet (tUCC)
- **Fixed Token Supply**: 18,000,000 tokens
- **Low Transaction Fees**: 0.00001 UCC/tUCC per standard transaction
- **Automatic Gas for Smart Contracts**: Dynamic gas calculation for contract execution

## Current Implementation Status

The Universe Chain testnet has been successfully deployed with the following configurations:

- **Chain ID**: `universe_9000-1`
- **Token Denomination**: `atucc` (atto-tUCC, where 1 tUCC = 10^18 atucc)
- **Total Supply**: 18,000,000 tUCC
- **Minimum Gas Price**: 10,000,000,000,000 atucc (0.00001 tUCC)
- **Address Format**: Addresses start with `ucc` prefix

All necessary APIs and services are operational:

- REST API (Cosmos SDK)
- JSON-RPC (Ethereum compatibility)
- gRPC services
- Rosetta API

## Setup Instructions

### Prerequisites

- Go 1.20 or later
- Git
- Make

### Installation Steps

1. **Clone the Repository**

```bash
git clone https://github.com/yourusername/universe-chain.git
cd universe-chain
```

2. **Install Dependencies**

```bash
make install
```

3. **Run the Universe Chain Testnet**

```bash
./scripts/universe_testnet.sh [YOUR_NODE_MONIKER]
```

This script will:
- Initialize the chain with ID `universe_9000-1`
- Set up a validator node
- Configure token denomination as `atucc`
- Allocate genesis tokens
- Update minimum gas prices
- Enable APIs and services

4. **Start the Chain**

```bash
$HOME/go/bin/evmosd start --home=$HOME/.universed
```

### Verifying the Setup

You can verify your setup with the following commands:

```bash
# Check the total token supply
curl -X GET "http://localhost:1317/cosmos/bank/v1beta1/supply"

# Check the latest block height
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  -H "Content-Type: application/json" http://localhost:8545
```

## Available APIs and Endpoints

### Cosmos REST API

- **Endpoint**: `http://localhost:1317`
- **Swagger Documentation**: `http://localhost:1317/swagger/`

Example
```bash
# Query account balance
curl -X GET "http://localhost:1317/cosmos/bank/v1beta1/balances/{address}" -H "accept: application/json"
```

### Ethereum JSON-RPC

- **HTTP Endpoint**: `http://localhost:8545`
- **WebSocket Endpoint**: `ws://localhost:8546`
- **Supported APIs**: eth, net, web3

Example:
```bash
# Get latest block number
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
  -H "Content-Type: application/json" http://localhost:8545
```

### gRPC Service

- **Endpoint**: `localhost:9090`

### Explorer Integration

The blockchain explorer frontend is built in Next.js. To integrate it with the backend:

1. Connect the explorer to the REST API for Cosmos-specific data
2. Connect to the JSON-RPC API for Ethereum-compatible data
3. Configure the explorer to display the correct token denomination (tUCC/UCC)

<!-- ## Roadmap and Next Steps

- **Mainnet Launch**: Deploy Universe Chain mainnet with UCC denomination
- **Multi-validator Setup**: Expand the validator set for better decentralization
- **Smart Contract Templates**: Provide pre-audited contract templates
- **Bridge Integration**: Enable cross-chain token transfers
- **Mobile Wallet Support**: Develop mobile wallet with UCC address format

## Contributing

Contributions to Universe Chain are welcome! Please refer to the general [Contributing](./CONTRIBUTING.md) guidelines and feel free to open issues or submit pull requests. -->
