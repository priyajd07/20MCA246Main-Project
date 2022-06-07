
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract onlineexamination {
  uint public r_count=0;
    mapping(uint => report) public reports;
    struct report{
       uint id;
	   uint bid;
        uint eid;
uint sid;
	  string score;
        string date;
    }
    function report_info(uint _bid,uint _eid,uint _sid,string memory _score,string memory _date)public{
        r_count++;
     reports[r_count]=report(r_count,_bid,_eid,_sid,_score,_date);
    }
}
