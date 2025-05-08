# Simple Voting Smart Contract

A TON blockchain smart contract that implements a single-proposal voting system with time-limited voting and unique voter identification.

## Overview

This smart contract allows users to vote "yes" or "no" on a single proposal. The contract implements various security measures and constraints to ensure fair and transparent voting.

## Features

- **Time-Limited Voting**: Voting is restricted to a specified duration
- **Vote Limit**: Maximum of 100 votes allowed per proposal
- **Unique Voter Identification**: Each blockchain address can vote only once
- **Immutable Votes**: Votes cannot be changed once cast
- **Gas Efficient**: Optimized for minimal gas consumption (under 0.1 Toncoin)
- **Fund Reimbursement**: Excess funds are automatically returned to voters

## Contract Structure

### Key Components

- **Vote Message**: Contains the voting choice (yes/no)
- **ProposalState**: Tracks the number of yes and no votes
- **Init**: Initialization parameters including proposal ID and voting deadline
- **Proposal Contract**: Main contract implementing the voting logic

### State Variables

- `totalCount`: Stores voting statistics and metadata
  - Bits 0-31: Voting deadline timestamp
  - Bits 32-39: Yes votes count
  - Bits 40-47: Total votes count
  - Bits 48-55: Current voter address hash

## Usage

### Deploying the Contract

1. Initialize the contract with:
   - `proposalId`: Unique identifier for the proposal
   - `votingEndingAt`: Unix timestamp when voting ends

### Voting

1. Send a `Vote` message with:
   - `value`: 0 for "no", 1 for "yes"

### Checking Results

Use the `proposalState()` getter method to retrieve:
- `yesCount`: Number of yes votes
- `noCount`: Number of no votes

## Error Codes

- 311: Duplicate vote attempt
- 312: Voting period has ended
- 313: Maximum vote limit (100) reached

## Security Features

- One vote per address
- Time-locked voting period
- Vote limit enforcement
- Automatic fund reimbursement
- Immutable votes

## Technical Requirements

- TON blockchain compatible
- Gas efficient (under 0.1 Toncoin per transaction)
- No fund freezing or burning
- Automatic excess fund return
