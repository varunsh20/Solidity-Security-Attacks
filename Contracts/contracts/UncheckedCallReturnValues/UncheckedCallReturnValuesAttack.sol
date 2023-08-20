// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract Game{
    uint256 public winAmount;
    address public  winner;
    bool public payed;

    function payWinner() public payable{
        require(!payed,"Already payed");
        payable(winner).send(winAmount); //Here the failure condition is not checked hence if the
                                        // transaction fails then other users can withdraw all of winner's
                                        //amount/
        payed = true;
    }

    function leftAmount() public payable{
        require(payed,"Winner not payed yet");
        payable(msg.sender).send(address(this).balance);
    }
}