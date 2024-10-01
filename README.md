# COW <> BALANCER Swap

This repository contains the OTC swap contract.

## Installation

It requires [Foundry](https://github.com/foundry-rs/foundry) installed to run. You can find instructions here [Foundry installation](https://book.getfoundry.sh/getting-started/installation).

To set up the project manually, run the following commands:

```sh
$ git clone https://github.com/gosuto-inzasheru/cow-balancer-swap.git
$ cd cow-balancer-swap/
$ npm install
$ forge install
```

## Setup

Duplicate `.env.example` and rename to `.env`:

- Add a valid mainnet URL for an Ethereum JSON-RPC client for the `RPC_URL` variable.
- Add the latest mainnet block number for the `BLOCK_NUMBER` variable.
- Add a valid Etherscan API Key for the `ETHERSCAN_API_KEY` variable.

### Commands

- `make build` - build the project
- `make test [optional](V={1,2,3,4,5})` - run tests (with different debug levels if provided)
- `make match MATCH=<TEST_FUNCTION_NAME> [optional](V=<{1,2,3,4,5}>)` - run matched tests (with different debug levels if provided)

### Deploy and Verify

- `Mainnet`: When you're ready to deploy and verify, run `./scripts/deploy_verify_mainnet.sh` and follow the prompts.
- `Testnet`: When you're ready to deploy and verify, run `./scripts/deploy_verify_testnet.sh` and follow the prompts.

To confirm the deploy was successful, re-run your test suite but use the newly created contract address.
