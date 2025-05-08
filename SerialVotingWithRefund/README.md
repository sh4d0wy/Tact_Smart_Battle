# Serial Voting System with Refunds

A TON blockchain smart contract system that implements a master contract for managing multiple voting proposals with automatic fund refunds. The system consists of two main contracts: ProposalMaster and Proposal, both implementing careful fund management.

## System Overview

The serial voting system allows for the creation and management of multiple voting proposals through a master contract. Each proposal maintains its own voting state and implements automatic refunds for excess funds. The system ensures proper fund management while maintaining all voting functionality.

## Key Features

- **Automatic Refunds**: Returns excess funds to transaction initiators
- **Master Contract Balance Management**: Maintains minimum balance of 0.01 TON
- **Sequential Proposal IDs**: Ordered proposal tracking
- **Time-Limited Voting**: Restricted to specified duration
- **Vote Limit**: Maximum of 100 votes per proposal
- **Unique Voter Identification**: One vote per blockchain address
- **Immutable Votes**: Votes cannot be changed once cast
- **Gas Efficient**: Optimized for minimal gas consumption

## Contract Structure

### ProposalMaster Contract
```tact
struct ProposalInit {
    master: Address;
    proposalId: Int as uint32;
}

message DeployNewProposal {
    votingEndingAt: Int as uint32;
}

message DeployNewProposalwithRefund {
    votingEndingAt: Int as uint32;
    sender: Address;
}
```

### Proposal Contract
```tact
message(121) Vote {
    value: Int as uint8;  // 0 for no, 1 for yes
}

struct ProposalState {
    yesCount: Int as uint8;
    noCount: Int as uint8;
    master: Address;
    proposalId: Int as uint8;
    votingEndingAt: Int as uint32;
}
```

## Fund Management

### ProposalMaster Contract
- Maintains minimum balance of 0.01 TON
- Accepts all funds if incoming amount is less than 0.01 TON
- Returns excess funds to transaction initiator
- Handles deployment costs efficiently

### Proposal Contract
- Automatically refunds excess funds to voters
- No fund freezing or burning
- Efficient fund handling
- Proper balance management

## State Variables

### ProposalMaster Contract
- `seqNo`: Sequential counter for proposal IDs

### Proposal Contract
- `master`: Address of the master contract
- `totalCount`: Stores voting statistics and metadata
  - Bits 0-31: Voting deadline timestamp
  - Bits 32-39: Yes votes count
  - Bits 40-47: Total votes count
  - Bits 48-55: Current voter address hash

## Usage

### Deploying the Contract
1. Send a `DeployNewProposal` message to the ProposalMaster contract
2. Include:
   - `votingEndingAt`: Unix timestamp when voting ends
3. Excess funds will be automatically refunded

### Voting
1. Send a `Vote` message to the specific proposal contract
2. Include:
   - `value`: 0 for "no", 1 for "yes"
3. Excess funds will be automatically refunded

### Checking Results
Use the `proposalState()` getter method to retrieve:
- `yesCount`: Number of yes votes
- `noCount`: Number of no votes
- `master`: Master contract address
- `proposalId`: Proposal identifier
- `votingEndingAt`: Voting deadline timestamp

## Error Codes

- 311: Invalid voting attempt (duplicate vote)
- 312: Voting period has ended
- 313: Maximum vote limit (100) reached
- 2025: Master contract impersonation attempt

## Technical Requirements

- **Gas Efficiency**: Under 0.1 Toncoin per transaction
- **Fund Management**: Proper refund handling
- **Master Balance**: Minimum 0.01 TON
- **Vote Validation**: Proper error handling
- **Time Management**: Accurate voting period enforcement

## Security Features

- One vote per address per proposal
- Time-locked voting periods
- Vote limit enforcement
- Master contract verification
- Immutable votes
- Gas optimization
- Secure fund handling

## Best Practices

1. **Fund Management**
   - Monitor contract balances
   - Ensure proper refunds
   - Maintain minimum balances
   - Track fund flows

2. **Proposal Management**
   - Set reasonable voting deadlines
   - Monitor proposal ID sequence
   - Verify master contract authenticity
   - Ensure proper initialization

3. **Voting**
   - Check voting deadlines
   - Verify voter eligibility
   - Monitor vote counts
   - Validate master contract address

4. **Security**
   - Never share private keys
   - Verify contract addresses
   - Monitor for unauthorized access
   - Validate all incoming messages

## Implementation Details

### Fund Handling
1. **Refund Mechanism**
   - Automatic excess fund return
   - No fund freezing
   - No fund burning
   - Efficient balance management

2. **Balance Management**
   - Minimum balance maintenance
   - Efficient fund acceptance
   - Proper fund distribution
   - Balance monitoring

## License

[Add your license information here] 