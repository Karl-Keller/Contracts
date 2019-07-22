pragma solidity ^0.4.21;

contract Referendum {
    
    struct Alternative {
        string  _name;
        uint    _votecount;
    }
    
    struct Participant {
        string  _name;
        bool    _authorized;
        bool    _voted;
        uint    _alternative;
    }
    
    address public owner;
    string public referendumName;
    
    mapping (address => Participant) public participants;
    Alternative[] public alternatives;
    uint public totalVotes;
    
    modifier OwnerOnly () {
        require(msg.sender == owner);
        _;
    }
    
    function Referendum(string _name) public {
        owner = msg.sender;
        referendumName = _name;
        
    }
    
    function AddAlternative (string _name) OwnerOnly public {
        alternatives.push(Alternative(_name, 0));
    }
    
    function GetNumAlternative () public view returns(uint) {
        return alternatives.length;
    }
    
    function AuthorizeParticipant (address _account) OwnerOnly public {
        participants[_account]._authorized = true;
    }
    
    function Vote (uint _alternativeIndex) public {
        
        require(!participants[msg.sender]._voted);
        require(participants[msg.sender]._authorized);
        
        participants[msg.sender]._alternative = _alternativeIndex;
        participants[msg.sender]._voted = true;
        
        totalVotes += 1;
        alternatives[_alternativeIndex]._votecount += 1;
    } 
    
    function endReferendum () OwnerOnly public {
        selfdestruct(owner);
    }
        
    
}