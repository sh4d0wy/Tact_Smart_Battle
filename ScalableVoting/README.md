# Scalable Voting System

A TON blockchain smart contract that implements a scalable voting system capable of handling up to 4 billion votes while maintaining strict storage constraints of 100,000 bits.

## System Overview

This voting system allows users to vote "yes" or "no" on a single proposal, with the ability to scale to billions of votes. The contract implements efficient storage mechanisms and strict validation rules while maintaining a small storage footprint.

## Key Features

- **Massive Scalability**: Supports up to 4 billion votes
- **Storage Efficient**: Maintains storage under 100,000 bits
- **Time-Limited Voting**: Restricted to specified duration
- **Unique Voter Identification**: One vote per blockchain address
- **Immutable Votes**: Votes cannot be changed once cast
- **Gas Efficient**: Optimized for minimal gas consumption

## Contract Structure

```tact
message(142) Vote {
    value: Int as uint8;  // 0 for no, 1 for yes
}

struct ProposalState {
    yesCount: Int as uint8;
    noCount: Int as uint8;
}

struct Init {
    proposalId: Int as uint8;
    votingEndingAt: Int as uint32;
}
```

## State Variables

- `totalCount`: Efficiently stores voting statistics and metadata
  - Bits 0-31: Voting deadline timestamp
  - Bits 32-39: Yes votes count
  - Bits 40-47: Total votes count
  - Bits 48-55: Current voter address hash

## Storage Optimization

The contract implements several optimizations to maintain the 100,000-bit storage limit while supporting billions of votes:

1. **Bit-Level Packing**: Efficient use of bit fields to store multiple values
2. **Compact State**: Minimal state variables with maximum information density
3. **Optimized Counters**: Efficient tracking of vote counts
4. **Smart Address Handling**: Compact voter address tracking

## Usage

### Deploying the Contract
1. Initialize with:
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

- 311: Invalid voting attempt (duplicate vote or voting period ended)
- 312: Voting period has ended
- 313: Maximum vote limit reached

## Technical Requirements

- **Storage Limit**: Maximum 100,000 bits
- **Gas Efficiency**: Under 0.1 Toncoin per transaction
- **Scalability**: Support for up to 4 billion votes
- **Vote Validation**: Proper error handling for invalid votes
- **Time Management**: Accurate voting period enforcement

## Security Features

- One vote per address
- Time-locked voting period
- Immutable votes
- Gas optimization
- Storage efficiency
- Scalable vote counting

## Best Practices

1. **Vote Management**
   - Monitor vote counts
   - Track voting deadlines
   - Validate voter addresses
   - Ensure storage efficiency

2. **Performance**
   - Optimize gas usage
   - Monitor storage usage
   - Track voting patterns
   - Maintain scalability

3. **Security**
   - Validate all votes
   - Protect against duplicate votes
   - Ensure proper time management
   - Monitor for unauthorized access

## Implementation Details

### Storage Optimization Techniques
1. **Bit Field Usage**
   - Efficient packing of multiple values
   - Minimal storage overhead
   - Quick access to individual fields

2. **Vote Counting**
   - Optimized counter implementation
   - Efficient state updates
   - Minimal storage impact

3. **Address Tracking**
   - Compact address representation
   - Efficient voter identification
   - Minimal storage overhead
