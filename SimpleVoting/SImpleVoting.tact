message(142) Vote {
    value: Int as uint8;
}
 
struct ProposalState {
    yesCount: Int as uint8;
    noCount: Int as uint8;
}
 
struct Init {
    proposalId: Int as uint8;
    votingEndingAt: Int as uint32;
}
 
contract Proposal {
    totalCount:Int as uint64=0;

    init(data: Init) {
        self.totalCount = data.votingEndingAt;
    }
 
    // deploy
    receive() { }
 
    receive(msg:Vote) {
        throwUnless(312, now()<=(self.totalCount & 0xFFFFFFFF));
        throwUnless(313,((self.totalCount>>40)&0xFF) < 100 );

        let senderhash = parseStdAddress(sender().asSlice()).address &0xFF;
        let currentAddress = (self.totalCount>>48) & 0xFF;
        
        throwUnless(311,senderhash!=currentAddress);

        let totalCount = (msg.value | (1<<8) | (senderhash<<16))<<32;
        self.totalCount +=totalCount;
        cashback(sender());
    }
 
     get fun proposalState(): ProposalState {

        let yesCount = self.totalCount>>32&0xFF;
        let totalCount = (self.totalCount>>40)&0xFF;

        return ProposalState{
            yesCount:yesCount,
            noCount:totalCount - yesCount
        }
    }
}

