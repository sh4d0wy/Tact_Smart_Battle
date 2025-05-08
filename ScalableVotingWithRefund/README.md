# Scalable Voting System with Refunds and Gas Management

A TON blockchain smart contract that implements a scalable voting system capable of handling up to 4 billion votes while maintaining strict storage constraints and implementing careful fund and gas management.

## System Overview

This voting system allows users to vote "yes" or "no" on a single proposal, with the ability to scale to billions of votes. The contract implements efficient storage mechanisms, automatic refunds, and robust gas management while maintaining a small storage footprint.

## Key Features

- **Massive Scalability**: Supports up to 4 billion votes
- **Storage Efficient**: Maintains storage under 100,000 bits
- **Automatic Refunds**: Returns excess funds to voters
- **Gas Management**: Handles failed transactions gracefully
- **Time-Limited Voting**: Restricted to specified duration
- **Unique Voter Identification**: One vote per blockchain address
- **Immutable Votes**: Votes cannot be changed once cast
- **Gas Efficient**: Optimized for minimal gas consumption

## Contract Structure

```tact
message(12) Vote {
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
  - Bits 32-35: Yes votes count
  - Bits 36-39: Total votes count
  - Bits 40-43: Current voter address hash

## Fund and Gas Management

### Fund Handling
- **Minimum Vote Value**: 0.1 TON required for voting
- **Automatic Refunds**: Returns excess funds to voters
- **No Fund Freezing**: All excess funds are returned
- **No Fund Burning**: No funds are permanently locked

### Gas Management
- **Transaction Recovery**: Handles failed transactions gracefully
- **Variable Gas Prices**: Adapts to changing gas costs
- **Retry Mechanism**: Allows voters to retry with higher gas
- **Efficient Operations**: Optimized for minimal gas usage

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
   - Minimum value: 0.1 TON
2. If transaction fails:
   - Retry with higher gas value
   - No penalty for failed attempts
   - Previous failed votes don't count

### Checking Results
Use the `proposalState()` getter method to retrieve:
- `yesCount`: Number of yes votes
- `noCount`: Number of no votes

## Error Codes

- 311: Invalid voting attempt (duplicate vote, insufficient funds, or voting period ended)

## Technical Requirements

- **Storage Limit**: Maximum 100,000 bits
- **Gas Efficiency**: Under 0.1 Toncoin per transaction
- **Scalability**: Support for up to 4 billion votes
- **Fund Management**: Proper refund handling
- **Gas Management**: Handle failed transactions
- **Vote Validation**: Proper error handling
- **Time Management**: Accurate voting period enforcement

## Security Features

- One vote per address
- Time-locked voting period
- Immutable votes
- Gas optimization
- Storage efficiency
- Scalable vote counting
- Secure fund handling
- Transaction recovery

## Best Practices

1. **Vote Management**
   - Monitor vote counts
   - Track voting deadlines
   - Validate voter addresses
   - Ensure storage efficiency

2. **Fund Management**
   - Monitor minimum vote value
   - Ensure proper refunds
   - Track fund flows
   - Handle failed transactions

3. **Gas Management**
   - Monitor gas prices
   - Handle failed transactions
   - Allow retry attempts
   - Optimize gas usage

4. **Performance**
   - Optimize gas usage
   - Monitor storage usage
   - Track voting patterns
   - Maintain scalability

5. **Security**
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

### Transaction Handling
1. **Failed Transaction Recovery**
   - Graceful handling of failures
   - No penalty for retries
   - Support for variable gas prices
   - Clear error reporting

2. **Gas Optimization**
   - Efficient operations
   - Minimal state changes
   - Optimized refund handling
   - Smart gas estimation

## License

[Add your license information here] 