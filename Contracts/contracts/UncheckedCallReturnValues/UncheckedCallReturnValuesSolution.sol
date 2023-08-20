// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract Game{
    uint256 public winAmount;
    address public  winner;
    bool public payed;

    function payWinner() public payable{
        require(!payed,"Already payed");
        bool sent = payable(winner).send(winAmount);
        require(sent,"Transaction failed");   //using this require statement we are checking 
                                            // if the transaction succedes or not. If not
        payed = true;
    }

    function leftAmount() public payable{
        require(payed,"Winner not payed yet");
         bool sent = payable(msg.sender).send(address(this).balance);
        require(sent,"Transaction failed"); 
    }
}