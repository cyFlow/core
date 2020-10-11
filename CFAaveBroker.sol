// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './ICFBroker.sol';


contract CFAaveBroker is  ICFBroker{

    //address of AAVE ladingPool contract on Ropsten
    address ladingPool = address(0x9E5C7835E4b13368fd628196C4f1c6cEc89673Fa);
    
    /*
      invest some array of assets
      input array of asset with amount for invest
      returns adress external contracts, methods, parameters and type call (delegate, static, call)
    */
    function invest (CFAsset[] calldata _assets) 
      external 
      override
      view 
      returns (address, string memory, bytes memory, CFEnumTypeCall)
   {
        require(_assets.length > 0);
        string memory _signature   = "deposit(address, uint256, uint16)";
        bytes memory _parameters = abi.encode(_assets[0].asset, _assets[0].amount, 0);
        return (ladingPool, _signature, _parameters, CFEnumTypeCall.delegatecall);
    
   }

    /*
      withdraw some array of assets
      input array of asset with amount for withdraw
      returns adress external contracts, methods, parameters and type call (delegate, static, call)
    */

   function withdraw (CFAsset[] calldata _assets) 
      external 
      view 
      override
      returns (address, string memory, bytes memory, CFEnumTypeCall)
   {
        require(_assets.length > 0);
        string memory  _signature  = "redeemUnderlying(address,address payable,uint256,uint256)";
        bytes memory _parameters = abi.encode(_assets[0].asset, tx.origin, _assets[0].amount, 0);

        return (ladingPool, _signature, _parameters, CFEnumTypeCall.delegatecall);
    }

}