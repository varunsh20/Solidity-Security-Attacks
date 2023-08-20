//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

contract CallingContract{
    address public caller;
    uint256 public num;
    uint256 public value;

    function setVars(uint256 _num) public payable{ 
        caller = msg.sender;
        num = _num;
        value = msg.value;
    }
}

//here we make a delegate call to calling contract and all the states of called contract are updated
// even if we call the function of called contract
contract CalledContract{
    address public caller;
    uint256 public num;
    uint256 public value;

    function setVars(uint256 _num,address _to) public{
       // (bool sent,) = _to.delegatecall(abi.encodeWithSelector(CallingContract
        //.setVars.selector,_num));
        (bool sent,) = _to.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num));
        require(sent,"Delegated call failed");
    }
}