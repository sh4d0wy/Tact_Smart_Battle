struct ProposalInit {
    master: Address;
    proposalId: Int as uint32;
}

message(124) DeployNewProposal {
    votingEndingAt: Int as uint32;
}

contract ProposalMaster {
    seqNo:Int as uint8=0;

    receive() {}

    receive(msg: DeployNewProposal) {        
        throwIf(311,now()>msg.votingEndingAt);
        let tempInit:ProposalInit = ProposalInit{
            master:myAddress(),
            proposalId:self.seqNo
        };
        
        deploy(DeployParameters{
            init: initOf Proposal(tempInit),
            value:0,
            mode: SendRemainingValue,
            body: DeployNewProposal{
                votingEndingAt:msg.votingEndingAt
            }.toCell()
        });

        self.seqNo = self.seqNo+1;
    }

    get fun nextProposalId(): Int {
        return self.seqNo;
    }
}

// ==============================================================================

message(123) Vote {
    value: Int as uint8;
}

struct ProposalState {
    yesCount: Int as uint8;
    noCount: Int as uint8;
    master: Address;
    proposalId: Int as uint8;
    votingEndingAt: Int as uint32;
}

contract Proposal {
    master:Address;
    totalCount:Int as uint64=0;

    init(data: ProposalInit) {
        throwIf(2025,sender()!=data.master);
        self.master = data.master;
    }

    receive(msg: Vote) {
        let senderhash = parseStdAddress(sender().asSlice()).address & 0xFF;
        throwIf(311,now()>(self.totalCount&0xFFFFFFFF));
        throwIf(311,((self.totalCount>>40)&0xFF) == 100 );
        throwIf(311,((self.totalCount>>48)&0xFF) == senderhash);
        self.totalCount += (msg.value|1<<8|senderhash<<16)<<32;
    }

    receive(msg: DeployNewProposal){
        throwIf(2025,sender()!=self.master);
        self.totalCount = msg.votingEndingAt;
    }

    get fun proposalState(): ProposalState { 
        let yesCount =(self.totalCount>>32)&0xFF;
        let totalCount = (self.totalCount>>40)&0xFF;
        let votingEndingAt = (self.totalCount)&0xFFFFFFFF; 
        return ProposalState{
            yesCount:yesCount,
            noCount:totalCount - yesCount,
            master:self.master,
            proposalId:0,
            votingEndingAt:votingEndingAt
        };
    }
}