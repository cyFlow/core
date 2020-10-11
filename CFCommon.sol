// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

/*
   Distributed assets 
*/
struct CFAsset
{
    address asset;
    uint256 amount;
}
/*
  type call 
*/
enum CFEnumTypeCall
{
    delegatecall,
    staticcall,
    call
}