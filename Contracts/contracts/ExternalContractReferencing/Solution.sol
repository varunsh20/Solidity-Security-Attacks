//SPDX-License-Identifier:GPL-3.0
pragma solidity 0.8.19;

import "./ExternalContract.sol";

contract Solution{
    
   ExternalContract externalContract;
    constructor(){         
        externalContract = new ExternalContract();    //Solution - instead of letting any user pass any parameter in 
                                    // your contract you should use new keyword to initialize an
                                    //instance of imported library or contract and then store it in
                                    // a state variable/
    }
}
