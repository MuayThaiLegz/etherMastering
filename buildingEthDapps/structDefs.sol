

/* STRUCT:

A struct is a user-defined type that contains a set of elements that in general are each of a 
different type. This example shows how a contract declaring various structs that get referenced in 
state variables, also how to use enums is s stuct
*/
pragma solidity >=0.5.0 <0.8.0;

contract Voting {
    enum UserType {Voter, Admin, Owner}

    enum MajorityType {SimpleMajority, AbsoluteMajority, SuperMajority, unanumity}

    struct UserInfo {
        address account;
        string name;
        string surname;
        UserType utype;
    }

    struct Candidate {
        address account;
        string description;
    }

    struct VotingSession {
        uint sessionId;
        string description;
        MajorityType majorityType;
        uint8 majorityPercent;
        Candidate[] candidates;
        mapping (address => uint) votes;
    }


    }
}

/* You can initialize a struct object as follows:

    uint numVotingSessions;
    mapping (uint => VotingSession) votingSessions;
    function addCandidate(uint votingSessionId, address candidateAddress, string cadidateDescripion) private {
        Candidate memory candidate = Candidate({account:candidateAddress, description:cadidateDescripion});

            votingSessions[votingSessionId].candidates.push(candidate);

    }
}
*/
}
