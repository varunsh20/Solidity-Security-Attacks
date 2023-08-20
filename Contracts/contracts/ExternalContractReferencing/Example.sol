//SPDX-License-Identifier:GPL-3.0
pragma solidity 0.8.19;

import "./ExternalContract.sol";

contract MyContract{
    
    ExternalContract externalContract;
    constructor(ExternalContract _externalContract){         //Vulnerability exists here as an attacker can give
                                            //any malicious contract address in your constructor
                                            // thus performing or spoiling your contract  
        externalContract = _externalContract;    
    }
}
