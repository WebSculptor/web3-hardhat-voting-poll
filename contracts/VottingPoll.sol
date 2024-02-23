// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingPoll {
    // Struct to represent a candidate
    struct Candidate {
        uint id;
        address candidateAddress;
        string name;
        uint voteCount;
    }

    // Mapping to store candidates
    mapping(uint => Candidate) public candidates;

    // Mapping to track whether a user has voted
    mapping(address => bool) public hasVoted;

    // Event to notify when a vote is cast
    event VoteCast(address indexed voter, uint indexed candidateId);

    // Function to add a candidate
    function addCandidate(
        string memory _name,
        address _candidateAddress,
        uint _candidateId
    ) external {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(
            candidates[_candidateId].id == 0,
            "Candidate ID already exists."
        );
        candidates[_candidateId] = Candidate(
            _candidateId,
            _candidateAddress,
            _name,
            0
        );
        emit CandidateAdded(_candidateId, _candidateAddress, _name);
    }

    // Event to notify when a candidate is added
    event CandidateAdded(
        uint indexed candidateId,
        address indexed candidateAddress,
        string name
    );

    // Function to cast a vote
    function vote(uint _candidateId) external {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(candidates[_candidateId].id != 0, "Invalid candidate ID.");
        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;
        emit VoteCast(msg.sender, _candidateId);
    }

    // Function to get the vote count for a candidate
    function getVoteCount(uint _candidateId) external view returns (uint) {
        return candidates[_candidateId].voteCount;
    }
}
