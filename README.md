# TON Smart Contract Voting System Contest

This repository contains a series of smart contract implementations for a voting system on the TON blockchain. Each implementation represents a different level of complexity and functionality, building upon the previous versions.

## Contest Structure

The contest consists of 5 levels, each focusing on different aspects of smart contract development:

### Level 1: Simple Voting Contract
**Folder: `SimpleVoting/`**
- Basic single-proposal voting system
- Limited to 100 votes
- Time-limited voting period
- One vote per address
- Simple fund management

### Level 2: Master Contract for Multiple Proposals
**Folder: `ScalableVoting/`**
- Master contract for deploying multiple proposals
- Sequential proposal IDs
- Time-limited voting periods
- One vote per address per proposal
- Basic fund management

### Level 3: Scalable Single-proposal Voting
**Folder: `ScalableVoting/`**
- Support for up to 4 billion votes
- Storage limit of 100,000 bits
- Time-limited voting period
- One vote per address
- Efficient storage optimization

### Level 4: Master Contract with Refunds
**Folder: `SerialVotingWithRefund/`**
- Master contract with fund management
- Automatic refunds for excess funds
- Minimum balance maintenance (0.01 TON)
- Sequential proposal IDs
- Careful fund handling

### Level 5: Scalable Voting with Refunds and Gas Management
**Folder: `ScalableVotingWithRefund/`**
- Support for 4 billion votes
- Storage limit of 100,000 bits
- Automatic refunds
- Gas management and transaction recovery
- Minimum vote value requirement (0.1 TON)

## Key Features Across Levels

1. **Voting Mechanics**
   - Yes/No voting options
   - Time-limited voting periods
   - Unique voter identification
   - Immutable votes

2. **Security Features**
   - Duplicate vote prevention
   - Time validation
   - Address verification
   - Error handling

3. **Technical Requirements**
   - Gas efficiency
   - Storage optimization
   - Fund management
   - Error handling

## Implementation Details

Each level's implementation includes:
- Smart contract code
- Detailed documentation
- Error handling
- State management
- Security measures

## Getting Started

1. Choose the level you want to explore
2. Navigate to the corresponding folder
3. Read the level-specific README.md
4. Review the implementation details
5. Test the contract functionality

## Best Practices

1. **Security**
   - Validate all inputs
   - Handle errors properly
   - Protect against attacks
   - Monitor contract state

2. **Performance**
   - Optimize gas usage
   - Efficient storage
   - Smart fund management
   - Proper error handling

3. **Maintenance**
   - Clear documentation
   - Code organization
   - Error tracking
   - State management

## Testing

Each level includes:
- Contract deployment instructions
- Voting process details
- Result checking methods
- Error handling examples

## Contributing

Feel free to:
- Review the implementations
- Suggest improvements
- Report issues
- Share your solutions

## License

[Add your license information here] 