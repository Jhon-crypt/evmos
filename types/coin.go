// Copyright Tharsis Labs Ltd.(Evmos)
// SPDX-License-Identifier:ENCL-1.0(https://github.com/evmos/evmos/blob/main/LICENSE)
package types

import (
	"math/big"

	sdkmath "cosmossdk.io/math"
)

const (
	// BaseDenom defines the default coin denomination used in Evmos in:
	//
	// - Staking parameters: denomination used as stake in the dPoS chain
	// - Mint parameters: denomination minted due to fee distribution rewards
	// - Governance parameters: denomination used for spam prevention in proposal deposits
	// - Crisis parameters: constant fee denomination used for spam prevention to check broken invariant
	// - EVM parameters: denomination used for running EVM state transitions in Evmos.
	BaseDenom        string = "aucc"
	BaseDenomTestnet string = "atucc"

	// BaseDenomUnit defines the base denomination unit for Evmos.
	// 1 evmos = 1x10^{BaseDenomUnit} aevmos
	BaseDenomUnit = 18

	// DisplayDenom defines the denomination displayed to users in client applications.
	DisplayDenom        string = "ucc"
	DisplayDenomTestnet string = "tucc"

	// DefaultGasPrice is default gas price for evm transactions
	// Setting it to 0.00001 UCC which is 10^13 aUCC
	DefaultGasPrice = 10000
)

// Total Supply for UCC - 18,000,000 UCC
var TotalSupply = int64(18000000)

// PowerReduction defines the default power reduction value for staking
var PowerReduction = sdkmath.NewIntFromBigInt(new(big.Int).Exp(big.NewInt(10), big.NewInt(BaseDenomUnit), nil))
