# Serial Voting System

A TON blockchain smart contract system that implements a master contract for managing multiple voting proposals in a serial manner. The system consists of two main contracts: ProposalMaster and Proposal.

## System Overview

The serial voting system allows for the creation and management of multiple voting proposals through a master contract. Each proposal is assigned a sequential ID and maintains its own voting state with strict validation rules.

## Architecture

### 1. ProposalMaster Contract
- Manages proposal deployment and sequencing
- Maintains a sequential proposal counter
- Validates proposal creation requests
- Deploys new proposal contracts

### 2. Proposal Contract
- Manages individual voting proposals
- Tracks votes and voting deadlines
- Enforces voting rules and constraints
- Verifies master contract authenticity

## Contract Structure

### ProposalMaster Contract
```tact
struct ProposalInit {
    master: Address;
    proposalId: Int as uint32;
}

message(124) DeployNewProposal {
    votingEndingAt: Int as uint32;
}

contract ProposalMaster {
    seqNo: Int as uint8;  // Sequential proposal counter
}
```

### Proposal Contract
```tact
message(123) Vote {
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

## Features

### ProposalMaster Features
- **Sequential ID Management**: Maintains ordered proposal IDs
- **Proposal Deployment**: Creates new proposal contracts
- **Deadline Validation**: Ensures valid voting periods
- **Access Control**: Validates proposal creation requests

### Proposal Features
- **Time-Limited Voting**: Restricted to specified duration
- **Vote Limit**: Maximum of 100 votes per proposal
- **Unique Voter Identification**: One vote per blockchain address
- **Immutable Votes**: Votes cannot be changed once cast
- **Master Contract Verification**: Prevents impersonation attempts
- **Gas Efficient**: Optimized for minimal gas consumption

## Usage

### Creating a New Proposal
1. Send a `DeployNewProposal` message to the ProposalMaster contract
2. Include:
   - `votingEndingAt`: Unix timestamp when voting ends

### Voting on a Proposal
1. Send a `Vote` message to the specific proposal contract
2. Include:
   - `value`: 0 for "no", 1 for "yes"

### Checking Results
Use the `proposalState()` getter method to retrieve:
- `yesCount`: Number of yes votes
- `noCount`: Number of no votes
- `master`: Master contract address
- `proposalId`: Proposal identifier
- `votingEndingAt`: Voting deadline timestamp

## Error Codes

- 311: Invalid voting attempt (duplicate vote, voting period ended, or vote limit reached)
- 2025: Master contract impersonation attempt

## Security Features

- One vote per address per proposal
- Time-locked voting periods
- Vote limit enforcement (100 votes)
- Master contract verification
- Immutable votes
- Gas optimization
- Sequential proposal tracking

## Technical Requirements

- TON blockchain compatible
- Gas efficient (under 0.1 Toncoin per transaction)
- Secure master contract verification
- Proper error handling
- Efficient state management
- Sequential proposal ID management

## Best Practices

1. **Proposal Creation**
   - Set reasonable voting deadlines
   - Monitor proposal ID sequence
   - Verify master contract authenticity
   - Ensure proper initialization

2. **Voting**
   - Check voting deadlines before casting votes
   - Verify voter eligibility
   - Monitor vote counts
   - Validate master contract address

3. **Security**
   - Never share private keys
   - Verify contract addresses
   - Monitor for unauthorized access attempts
   - Validate all incoming messages