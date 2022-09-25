//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

    


contract Voting {


    struct Candidate {
        string candidate_name;
        uint voteCount;
    }

    struct election{
        string election_name;
        uint election_id;
        uint endtime;
        // uint numOfApplicant;
        // mapping(uint=>address) candidatesIDToCandidate;
        address[] voters;
        address[] idToCandidates;
        address[] idToApplicants;
    }

    mapping(address=>Candidate) candidates;
    mapping(address=>Candidate) applicants;


    struct Voter {
        address voter_id;
        bool voted;
    }

    // struct Applicant {
    //     string candidate_name;
    //     uint candidate_id;
    // }

    struct results{
        string election_name;
        string winner_name;
    }

    //election_authority's address
    address admin;

    constructor(){
        admin = msg.sender;
    }

    election[] public allElections;
    uint public numOfElections = 0;
    // Voter[] public voters;
    // uint public numVoter = 0;


    function createElection(string memory name) public{
        require(msg.sender==admin);
        address[] memory add;
        // election storage e;
        //  = allElections[numOfElections];
        election memory e=election({
            election_name:name,
            election_id:numOfElections,
            endtime:block.timestamp+2 days,
            voters:add,
            idToCandidates: add,
            idToApplicants:add
        });
        // e.election_name = name;
        // e.election_id = numOfElections;
        // e.endtime = block.timestamp;
        allElections.push(e);
        ++numOfElections;

        // election e = election();
        // allElections.push(election);
        // allElections[numOfElections++] = election(name, numOfElections++ ,block.timestamp + time, 0, candi, appli); // Check last word
    }


    function addApplicant(string memory name, uint elect_id) public{
        address add = msg.sender;
        allElections[elect_id].idToApplicants.push(add);
        applicants[add]=Candidate(name,0);
        // allElections[elect_id].applicants[_add]=Applicant(ApplicantName);
    }

    function approveApplicant(uint ele_id,uint app_id) public{
        // for(uint i = 0; i < allElections.length; i++){
        //     if(allElections[i].election_id == ele_id){
        //         allElections[i].candidates.push(Candidate(allElections[i].applicants[candi_id].candidate_name, candi_id, 0));
        //     }
        // }
        require(msg.sender==admin);
        address applicant = allElections[ele_id].idToApplicants[app_id];
        allElections[ele_id].idToCandidates.push(applicant);
        candidates[applicant]=applicants[applicant];
    }

    // function addVoter(address voter_address) public {
    //     voters.push(Voter(voter_address, false));
    // }


    function vote( uint elec_id, uint candi_id) public {

        // for(uint i = 0; i < voters.length; i++){
        //     if(voters[i].voter_id == voter_add){
        //         require(!voters[i].voted, "Error:You cannot double vote");  
        //         allElections[election_id].candidates[candi_id].voteCount++;
        //     }
        // }
        address voter_add = msg.sender;
        allElections[elec_id].voters.push(voter_add);
        candidates[allElections[elec_id].idToCandidates[candi_id]].voteCount++;
    }

    function getApplicant(uint elect_id, uint appl_id) view public returns(string memory){
        return applicants[allElections[elect_id].idToApplicants[appl_id]].candidate_name;

    }
    
    function seeResult(uint elec_id) view public returns(string memory) {
            // uint i = elec_id;
            // string memory win;
            // if(allElections[i].time < block.timestamp){
            //     win = allElections[i].candidates[0].candidate_name;
            //     uint max = allElections[i].candidates[0].voteCount;
            //     for(uint j = 1; j < allElections[i].candidates.length; j++){
            //         if(allElections[i].candidates[j].voteCount > max){
            //             max = allElections[j].candidates[j].voteCount;
            //             win = allElections[i].candidates[j].candidate_name;
            //         }
            //     }
                
            // }else{
            //     return ("no", "no");
            // }
        
        uint max = 0;
        for(uint i=0;i<allElections[elec_id].idToApplicants.length;i++){
            if(candidates[allElections[elec_id].idToCandidates[i]].voteCount>candidates[allElections[elec_id].idToCandidates[max]].voteCount){
                max = i;
            }
        }
        return candidates[allElections[elec_id].idToCandidates[max]].candidate_name;
    }

    function getElection(uint eid) view public returns(string memory){
        return allElections[eid].election_name;
    }
    function getNumOfApplicantInElection(uint elect_id) view public returns(uint){
        return allElections[elect_id].idToApplicants.length;
    } 
}