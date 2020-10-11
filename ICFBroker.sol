// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './CFCommon.sol';

/*
  interface of cast broker
*/
interface ICFBroker {

    /*
      invest some array of assets
      input array of asset with amount for invest
      returns adress external contracts, methods, parameters and type call (delegate, static, call)
    */
    function invest (CFAsset[] calldata _assets) external view returns (address, string memory, bytes memory, CFEnumTypeCall);
    
    
    /*
      withdraw some array of assets
      input array of asset with amount for withdraw
      returns adress external contracts, methods, parameters and type call (delegate, static, call)
    */
    function withdraw (CFAsset[] calldata _assets) external view returns (address, string memory, bytes memory, CFEnumTypeCall);

}
