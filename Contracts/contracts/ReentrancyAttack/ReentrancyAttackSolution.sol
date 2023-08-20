// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

contract Bank{

    //Solution-1
    //locking up contract during a certain code execution and preventing re-entrancy calls.You
    //can also use openzepplins ReentrancyGuard modifier.
    bool public lock;

    modifier nonReentrant{
        require(!lock,"Code is still in execution");
        lock = true;
        _;
        lock  = false;
    }

    mapping(address=>uint256) public balances;

    function deposit() public payable{
        require(msg.value>= 1 ether,"Amount should be greate than or equal to 1 ether");
        balances[msg.sender]+=msg.value;
    }

    function withdraw() public nonReentrant{
        require(balances[msg.sender]>0,"You have no funds to withdraw");
        balances[msg.sender] = 0;  //Solution-2  update all changes in state variables before
                                    //making any external call.

        (bool sent,) = msg.sender.call{value:balances[msg.sender]}("");
        require(sent,"Transaction failed");

        //Solution -3
        //can use msg.sender.transfer(balances[msg.sender]) instead of call, as transfer uses
        // only 2300 gas and it will be not enough for attacking contract to make external calls 
        // to this contract(re-enter).
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