// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract ExternalContract{

    function add(uint256 a,uint256 b) public pure returns(uint256){
        return a+b;
    }
}