// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

contract CFEnvironment
{
    address constant public tokenETH = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
    
    function getETH() external view returns(address)
    {
        return tokenETH;
    }
}
