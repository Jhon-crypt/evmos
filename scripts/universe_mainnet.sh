#!/bin/bash

set -e

# Check if MONIKER is provided, otherwise set a default
if [ -z "$1" ]; then
  MONIKER="universe-mainnet-node"
else
  MONIKER=$1
fi

# Define directories and configuration
CHAINID="universe_1-1"
BINARY="$HOME/go/bin/evmosd"
HOME_DIR="$HOME/.universed"
CONFIG_DIR="$HOME_DIR/config"
KEYRING="test"

echo "Setting up Universe Chain (Mainnet)"
echo "Moniker: $MONIKER"
echo "Chain ID: $CHAINID"
echo "Home Directory: $HOME_DIR"

# Remove previous data if exists
rm -rf $HOME_DIR

# Initialize the chain
echo "Initializing chain..."
$BINARY init $MONIKER --chain-id=$CHAINID --home=$HOME_DIR

# Update the staking denom from stake to aucc
echo "Updating stake to aucc in genesis.json..."
sed -i '' 's/"stake"/"aucc"/g' $CONFIG_DIR/genesis.json

# Fix chain_id in the config file
echo "Updating chain_id in config.toml..."
sed -i '' 's/chain-id = ""/chain-id = "universe_1-1"/g' $CONFIG_DIR/client.toml
sed -i '' 's#"chain_id": ""#"chain_id": "universe_1-1"#g' $CONFIG_DIR/genesis.json

# Configure validator 
echo "Setting up validator..."
$BINARY keys add validator --keyring-backend=$KEYRING --home=$HOME_DIR
VALIDATOR_ADDRESS=$($BINARY keys show validator -a --keyring-backend=$KEYRING --home=$HOME_DIR)

# Add genesis account with tokens
echo "Adding genesis account..."
$BINARY add-genesis-account $VALIDATOR_ADDRESS 18000000000000000000000000aucc --home=$HOME_DIR

# Create genesis transaction
echo "Creating genesis transaction..."
$BINARY gentx validator 1000000000000000000000aucc --chain-id=$CHAINID --keyring-backend=$KEYRING --home=$HOME_DIR

# Collect genesis transactions
echo "Collecting genesis transactions..."
$BINARY collect-gentxs --home=$HOME_DIR

# Set minimum gas price
echo "Updating minimum gas price..."
sed -i '' 's/minimum-gas-prices = "0stake"/minimum-gas-prices = "10000000000000aucc"/g' $CONFIG_DIR/app.toml

# Enable API and services
echo "Configuring API and other services..."
sed -i '' 's/enable = false/enable = true/g' $CONFIG_DIR/app.toml
sed -i '' 's/swagger = false/swagger = true/g' $CONFIG_DIR/app.toml
sed -i '' 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/g' $CONFIG_DIR/app.toml

# Disable versionDB as it's not supported in the default build
echo "Disabling versionDB..."
sed -i '' '/\[versiondb\]/,/^\[/ s/enable = true/enable = false/' $CONFIG_DIR/app.toml

# Create the config directory for the Evmos binary
echo "Creating config for evmosd app..."
mkdir -p "$HOME/.evmosd/config"
echo "universe_1-1" > "$HOME/.evmosd/config/genesis_chain_id" 

echo "Universe Chain (Mainnet) setup complete!"
echo "To start the chain, run:"
echo "$BINARY start --home=$HOME_DIR" 