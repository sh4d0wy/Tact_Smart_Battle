struct ProposalInit {
    master: Address;
    proposalId: Int as uint32;
}

message DeployNewProposal {
    votingEndingAt: Int as uint32;
}

message DeployNewProposalwithRefund{
    votingEndingAt: Int as uint32;
    sender: Address;
}
contract ProposalMaster {
    seqNo:Int as uint8 = 0;
    receive() {
         if(context().value <= 10000000) {
            return;
         }
        if (myBalance() >= 10000000) {
            send(SendParameters{
                to: sender(),
                value: myBalance() - 12000000,
                mode: SendIgnoreErrors,
            });
        }
        
    }

    receive(msg: DeployNewProposal) {        
        throwUnless(313,now()<=msg.votingEndingAt);

        let tempInit:ProposalInit = ProposalInit{
            master:myAddress(),
            proposalId:self.seqNo
        };
        
        deploy(DeployParameters{
            init: initOf Proposal(tempInit),
            value:0,
            mode: SendRemainingValue,
            body: DeployNewProposalwithRefund{
                votingEndingAt:msg.votingEndingAt,
                sender:sender()
            }.toCell()
        });

        self.seqNo+=1;
    }

    get fun nextProposalId(): Int {
        return self.seqNo;
    }
}

// ==============================================================================

message(121) Vote {
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
        throwUnless(2025,sender()==data.master);
        self.master = data.master;
    }

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

    receive(msg: DeployNewProposalwithRefund){
        throwUnless(2025,sender()==self.master);
        self.totalCount = msg.votingEndingAt;
        cashback(msg.sender);
    }
 
    get fun proposalState(): ProposalState {  
        let yesCounsAt = self.totalCount>>32&0xFF;
        let totalCount = (self.totalCount>>40)&0xFF;
        let votingEndingAt = self.totalCount & 0xFFFFFFFF;

        return ProposalState{
            yesCount:yesCount,
            noCount:totalCount - yesCount,
            master:self.master,
            proposalId:0,
            votingEndingAt:votingEndingAt
        };
    }
}