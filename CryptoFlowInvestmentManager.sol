pragma solidity ^0.6.12;

//import 

//import

contract InvestmentManager{         //declare contract
       address payable momsWallet;
       address cryptoFlow;
       CryptoFlow c;
       constructor(address _momsWallet, address _cryptoFlow) public payable {
        momsWallet = _momsWallet;
        cryptoFlow = _cryptoFlow;
        c=CryptoFlow(_cryptoFlow);
        c.invest{value: msg.value}(momsWallet,msg.value);
       }
    
    
        
        function earningstodate() public view returns(uint256){
            return c.earningstodate(momsWallet);
            
        }
        function cashoutinvestment() public returns(uint256){
            return c.cashoutinvestment(momsWallet);
            
        }
    
}
