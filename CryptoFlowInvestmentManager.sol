pragma solidity ^0.5.2;

//import 

//import

contract InvestmentManager{         //declare contract
    struct Investment{              //model a investment
        uint EarningsToDate;
        uint amountCashedOut;
    }
       constructor(address _momsWallet, address _cryptoFlow) public payable {
        momsWallet = _momsWallet;
        cryptoFlow = _cryptoFlow;

    }
    
    }
    uint constant=5;
    mapping(uint=>EarningsToDate) public earnings;   //stores mom's investments
        uint private amount;
        function EarningsToDate(address momsWallet) public returns(uint256){
            amount++;
            earnings[amount]=EarningsToDate(amount,momsWallet);
            return 0;
        }
        function cashOutinvestment(address cryptoFlow) public returns(uint256){
            amountCashedOut=amountCashedOut+constant;
            return 0;
        }
    }
}