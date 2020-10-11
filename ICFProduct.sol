// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './CFCommon.sol';

/*
  interface of product
*/
interface ICFProduct {

    /*
      invest ETH
      input address sender and amount to invest
    */
    function invest (address _sender, uint256 _amount) external;

    /*
      withdraw ETH
      input address sender
    */
    function withdraw (address _sender) external;
    
    /*
       How many eanoing todaty
    */
    function getEarningsToDate(address _sender) external view returns (uint256);
    
    /*
       Rate of current interest    
    */
    function getCurrentInterestRate(address _sender) external view returns (uint256);

}
