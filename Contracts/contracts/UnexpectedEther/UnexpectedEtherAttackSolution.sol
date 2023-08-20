// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

contract WinnerGame{

    uint256 public constant target = 7 ether;
    address public winner;

    //Solution - instead of using address(this).balance, maintain a state variable for storing
    // the balance and update its state in every payable function.

    uint256 public balance;

    function deposit() public payable{
        require(msg.value==1 ether,"You can only deposit 1 ether");
        balance+=msg.value;
        require(balance<target,"Game over");   
        if(balance>=target){
            winner = msg.sender;
        }
    }

    function claimWinnerAmount() public{
        require(msg.sender==winner,"Only Winner can claim");
        (bool sent,) = winner.call{value:balance}("");
        require(sent,"Transaction failed");
    }
}

contract Attack{

    function attack(address payable game) public payable{
        selfdestruct(game);  
    }
}