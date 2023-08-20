//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract Victim{

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function deposit() public payable{}

    //Solution - always use msg.sender for authentication so that it is able to identify from where
    // the call is being made, as tx.origin always points to the EOA where the transaction was
    //originated.
    function withdraw(address _to,uint256 _amount) public payable{
        require(msg.sender==owner,"Only owner can call this function");
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
        victim.withdraw(owner,address(victim).balance);  
    }
}