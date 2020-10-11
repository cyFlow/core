//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import "./ICFProduct.sol"; 

contract CryptoFlowInvestmentManager{         //declare contract
      
    address payable momsWallet;
    address cryptoFlowAddress;
    ICFProduct cryptoFlow;
       
    constructor(address payable _momsWallet, address _cryptoFlow) public payable {
       momsWallet = _momsWallet;
       cryptoFlowAddress = _cryptoFlow;
       cryptoFlow=ICFProduct(_cryptoFlow);
       cryptoFlow.invest{value: msg.value}(momsWallet,msg.value);
    }
    
    function earningstodate() public view returns(uint256){
        return cryptoFlow.getEarningsToDate(momsWallet);
            
    }
    
    function cashoutinvestment() public returns(uint256){
        return cryptoFlow.withdraw(momsWallet);            
    }
    
}

