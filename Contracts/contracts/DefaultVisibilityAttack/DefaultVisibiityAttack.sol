//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.5.12;

contract DefaultVisibility{

    function winner() payable{
        require(msg.sender==0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,"not winner");
        sendWinner();
    }
    //Anyone can use this public function to tranfer amount into their address, hence its better
    // to specify visibilities in your functions and state variables.
    function sendWinner(){
        msg.sender.transfer(address(this).balance);
    }
}