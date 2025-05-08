message(12) Vote {
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
            throwIf(311,context().value<100000000);
            throwIf(311,(self.totalCount & 0xFFFFFFFF) < now());
            
            let sender = parseStdAddress(sender().asSlice()).address & 0x0F;
            throwIf(311,sender==((self.totalCount>>40)&0x0F));
            
            let totalCount = (msg.value | (1<<4) | (sender<<8)) << 32;
            self.totalCount+=totalCount;
            cashback(sender());
        }

        get fun proposalState(): ProposalState {
            let yesCount = (self.totalCount>>32) & 0x0F;
            let totalCount = (self.totalCount>>36 ) & 0x0F;

            return ProposalState{
                yesCount:yesCount,
                noCount:totalCount-yesCount
            }
        }
}
    