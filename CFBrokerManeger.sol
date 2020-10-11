// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './ICFBroker.sol';
import './CFEnvironment.sol';


contract CFBrokerManager
{
    mapping(address=>address) mapBroker;
    
    CFEnvironment  private env;
    
    constructor() public
    {
        address _env = address(0xc8848086E7e3eb34DEd2DE9273545064ac0EAa56);
        env = CFEnvironment(_env);
    }

   modifier broker (address _name) {
        require(mapBroker[_name] != address(0x0), 'It`s not broker');
        _;
    }

   modifier newbroker (address _name) {
        require(mapBroker[_name] == address(0x0), 'Broker with same name is exist');
        _;
    }
    
    function isBroker(address _name) external view returns (bool)
    {
        return (mapBroker[_name] != address(0x0));
    }
    
    function makeCheckParameters() private view returns(CFAsset[] memory)
    {
        CFAsset memory _asset = CFAsset({asset:env.getETH(), amount:0});
        CFAsset[] memory _assets = new CFAsset[](2);
        _assets[0] = _asset;
        _assets[1] = _asset;
        return _assets;
    }
    
    function checkInvest(address _broker) private view returns(bool)
    {
        bytes memory _callFunc =  abi.encodeWithSignature("invest(CFAsset[] calldata _assets)", makeCheckParameters());
        (bool success, bytes memory result) = _broker.staticcall(_callFunc);
        return success;
    }
    
    function checkWithdraw(address _broker) private view returns(bool)
    {
        
        bytes memory _callFunc =  abi.encodeWithSignature("withdraw(CFAsset[] calldata _assets)", makeCheckParameters());
        (bool success, bytes memory result) = _broker.staticcall(_callFunc);
        return success;
    }
     
    function check(address _broker) private view returns(bool)
    {
       return checkInvest(_broker) 
           && checkWithdraw(_broker);
    }
    function add(address _name, address _broker) external newbroker(_name)
    {
        //require(check(_broker), 'The broker isn`t use interface ICFBroker');
        mapBroker[_name] = _broker;
    }
    

    function call(address _contract, string memory _func, bytes memory _parameters, CFEnumTypeCall _typeCall) private
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

        require(success, 
              "Execution failed"
        );
        
    }
    
    function getCallBrokerInvest(ICFBroker _broker, CFAsset[] memory _assets) 
      private 
      view 
      returns (address, string memory, bytes memory, CFEnumTypeCall _typeCall)
      {
         return  _broker.invest(_assets);
      }
    
    function invest(address _name, CFAsset[] calldata _assets) external broker(_name)
    {
       ICFBroker _broker = ICFBroker(mapBroker[_name]);
       (address _contract
      , string memory _func
      , bytes memory _parameters
      , CFEnumTypeCall _typeCall
      ) = getCallBrokerInvest(_broker, _assets);
      
      call(_contract, _func, _parameters, _typeCall);
    }

    function getCallBrokerWithdraw(ICFBroker _broker, CFAsset[] memory _assets) 
      private 
      view 
      returns (address, string memory, bytes memory, CFEnumTypeCall _typeCall)
      {
         return  _broker.invest(_assets);
      }

    function withdraw(address _name, CFAsset[] calldata _assets) external broker(_name)
    {
       ICFBroker _broker = ICFBroker(mapBroker[_name]);
       (address _contract
      , string memory _func
      , bytes memory _parameters
      , CFEnumTypeCall _typeCall
      ) = getCallBrokerWithdraw(_broker, _assets);
      
      call(_contract, _func, _parameters, _typeCall);
    }
    
}