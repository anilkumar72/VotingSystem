//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.26;
import "hardhat/console.sol";

contract VotingSystem {
    address public pollingOfficer;

    struct Candidate {
        string name;
        uint256 id;
        uint256 voteCount;
        bool approved;
    }

    struct Voter {
        string name;
        uint256 id;
        bool voted;
        address votedTo;
    }

    mapping(address => Candidate) private candidates;
    address[] private candidateAddresses;
    mapping(address => Voter) private voters;
    address[] private votersAddresses;

    constructor(){
        pollingOfficer = msg.sender;
    }

    function registerCandidate(string memory _name) external {
        require(candidates[msg.sender].id == 0, 'Candidate already registered');
        candidates[msg.sender] = Candidate(_name, candidateAddresses.length + 1, 0, false);
        candidateAddresses.push(msg.sender);
    }

    function getCandidateByAddress(address _address) public view returns (string memory, uint256, uint256, bool) {
        require(candidates[_address].id != 0, "Candidate does not exist");
        Candidate storage candidate = candidates[_address];
        return (candidate.name, candidate.id, candidate.voteCount, candidate.approved);
    }

    function getAllCandidates() public view returns(address[] memory){
        console.log(votersAddresses,'votersAddresses');
        return votersAddresses;
    }

    function approveCandidate(address _candidateAddress) external {
        require(msg.sender == pollingOfficer, 'Only poling officer can approve candidate');
        require(candidates[_candidateAddress].id != 0, 'Candidate did not exist');
        candidates[_candidateAddress].approved = true;
    }

    function registerVoter(string memory _name) external {
        require(voters[msg.sender].id == 0, 'Voter already registered');
        voters[msg.sender] = Voter(_name, votersAddresses.length + 1, false, address(0));
        votersAddresses.push(msg.sender);
    }

    function voteOnCandidate(address _candidateAddress) external {
        require(voters[msg.sender].id != 0 && voters[msg.sender].voted == false, "Voter Not registered or you already voted");
        require(candidates[_candidateAddress].id != 0 && candidates[_candidateAddress].approved == true, 'candidate not existed or not approved');
        candidates[_candidateAddress].voteCount++;
        voters[msg.sender].voted = true;
        voters[msg.sender].votedTo = _candidateAddress;
    }

    function declareWinner() external view returns (uint256,address){
        address winnerAddress;
        uint256 highestVoteCount;

        for (uint256 i = 0; i < candidateAddresses.length; i++) {
            address currentCandidate = candidateAddresses[i];
            if(candidates[currentCandidate].voteCount > highestVoteCount){
                highestVoteCount = candidates[currentCandidate].voteCount;
                winnerAddress = currentCandidate;
            }

        }
        return(highestVoteCount,winnerAddress);

    }
}