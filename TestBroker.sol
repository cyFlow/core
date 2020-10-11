// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './ICFBroker.sol';
import './CFEnvironment.sol';
import './CFBrokerManeger.sol';


contract TestBroker
{
    
    function isBroker(address _name) external view returns(bool)
    {
        address _brokerManager = address(0xCe4975E8004Efd08990299B019153ADEF7a19C54);
        CFBrokerManager brokerManager = CFBrokerManager(_brokerManager);
        return brokerManager.isBroker(_name);
    }
    
    function addAaveBroker() external returns(bool)
    {
      address aBroker = address(0xFd2d7751F84F9D86C460F7ea90645B760e58b8d9);
      address _brokerManager = address(0xCe4975E8004Efd08990299B019153ADEF7a19C54);
      CFBrokerManager brokerManager = CFBrokerManager(_brokerManager);
      address aNameBroker = address(0xB72Fa7ecb92BA7D00470560a152269f96264fD08);
      brokerManager.add(aNameBroker, aBroker);
      return brokerManager.isBroker(aNameBroker);
    }

    function call(address _contract, string memory _func, bytes memory _parameters, CFEnumTypeCall _typeCall) private returns(bool)
    {
        bytes memory _callFunc =  abi.encodeWithSignature( _func, _parameters);
        bool success; 
        bytes memory result;
        
        if(_typeCall == CFEnumTypeCall.delegatecall)
          (success, result) = _contract.delegatecall(_callFunc);
        if(_typeCall == CFEnumTypeCall.staticcall)
          (success, result) = _contract.staticcall(_callFunc);
        if(_typeCall == CFEnumTypeCall.call)
          (success, result) = _contract.call(_callFunc);

        return success;
    }
    
    function getCallBrokerInvest(ICFBroker _broker, CFAsset[] memory _assets) 
      private 
      view 
      returns (address, string memory, bytes memory, CFEnumTypeCall _typeCall)
      {
         return  _broker.invest(_assets);
      }
    
    function invest() external returns (bool)
    {
      address aBroker = address(0xFd2d7751F84F9D86C460F7ea90645B760e58b8d9);
      address _env = address(0xc8848086E7e3eb34DEd2DE9273545064ac0EAa56);
      CFEnvironment env = CFEnvironment(_env);
  
      ICFBroker _broker = ICFBroker(aBroker);
       
      CFAsset memory _asset = CFAsset({asset:env.getETH(), amount:1000000000000});
      CFAsset[] memory _assets = new CFAsset[](1);
       _assets[0] = _asset;

       
       (address _contract
      , string memory _func
      , bytes memory _parameters
      , CFEnumTypeCall _typeCall
      ) = getCallBrokerInvest(_broker, _assets);
      
      return call(_contract, _func, _parameters, _typeCall);
    }
    
            

}