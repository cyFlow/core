pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./CryptoFlowInvestmentManager.sol";

/**
 * The CryptoFlow Deposit Manager Contract is responsible for enabling mom to deposit her funds into the CryptoFlow system. 
 * It is responsible for spawning Investement Manager Contracts that manage mom's investment into a given CryptoFlow. 
 * 
 * @author Tony Kunz
 * Date 2020 October 10
 *
 */

contract CryptoFlowDepositManager { 
    
    
     mapping(address=>address []) momsOpenInvestments; 
     mapping(address=>address []) momsClosedInvestments;
     mapping(string=>address) cryptoFlows; 
     string [] availableCryptoFlows; 
   
   
     /**
      * Register a new crypto flow when it's avalable. 
      */ 
     function registerCryptoFlow(string memory cryptoFlowName, address cryptoFlowContractAddress) public returns (bool) { 
            availableCryptoFlows.push(cryptoFlowName);
            cryptoFlows[cryptoFlowName] = cryptoFlowContractAddress;
            return true;     
     }
   
     /** 
      * Return all the Flow names 
      */ 
     function getAvailableCryptoFlows() public view returns (string [] memory flowNames) {
         return availableCryptoFlows;
     }
   
     /**
     * Deposit mom's ETH into CryptoFlow 
     */ 
    function deposit( address momsWallet, uint256 depositAmount, string memory cryptoFlowName)public payable returns (address momsInvestmentManagerContract) { 
        require(msg.sender == momsWallet);
        require(msg.value == depositAmount);
        
        address cryptoFlowAddress = cryptoFlows[cryptoFlowName];
        
        CryptoFlowInvestmentManager momsInvestment = new CryptoFlowInvestmentManager{value : depositAmount}(momsWallet, cryptoFlowAddress);    
        
        address momsInvestmentAddress = address(momsInvestment);
        momsOpenInvestments[momsWallet].push(momsInvestmentAddress);
        
        return momsInvestmentAddress; 
    }

    /**
     * Get all the address for mom's investments that are open 
     * 
     * 
     */ 
    function getMomsOpenInvestments(address momsWallet) public view returns (address[] memory investments) {
        return momsOpenInvestments[momsWallet]; 
    }
    
    
    /**
     * Get all the addresses for mom's investments that are closed 
     * 
     */ 
    function getMomsClosedInvestments(address momsWallet) public view returns (address[] memory investments) {
        return momsClosedInvestments[momsWallet]; 
    }
    
    /**
     * Close mom's investment once it's done this should be called by the Mom's Investement Manager Contract
     * 
     */ 
    function closeInvestment(address momsWallet, address momsInvestment) public returns (bool){
        require(msg.sender == momsInvestment); // only the investment can close itself
        for(uint256 x = 0 ; x < momsOpenInvestments[momsWallet].length; x++ ) { 
            address investment = momsOpenInvestments[momsWallet][x];
            if(investment == momsInvestment) {
                delete momsOpenInvestments[momsWallet][x];
            }
        }
        momsClosedInvestments[momsWallet].push(momsInvestment);
    }

} 
