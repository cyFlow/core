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
    function invest (address __momswallet, uint256 _amount) payable external;

    /*
      withdraw ETH
      input address sender
    */
    function withdraw (address payable _momswallet)  external returns (uint256);
    
    /*
       How many eanoing todaty
    */
    function getEarningsToDate(address __momswallet) external view returns (uint256);
    
    /*
       Rate of current interest    
    */
    function getCurrentInterestRate(address __momswallet) external view returns (uint256);

}
