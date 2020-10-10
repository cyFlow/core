pragma solidity ^0.6.6;

contract CFAaveBrokerTest {

    address ladingPool = address(0x9E5C7835E4b13368fd628196C4f1c6cEc89673Fa);
    
    function invest (uint256 _amount) public payable{
        bytes memory _parameters = abi.encode(address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE), _amount, 0);
        bytes memory _callFunc =  abi.encodeWithSignature("deposit(address, uint256, uint16)", _parameters);

        (bool success, bytes memory result) = ladingPool.delegatecall(_callFunc);
        
        require(success, 
              "Execution failed"
        );
    }

    function  getUserReserveData() public view 
     returns(uint256)
    {
        address asset = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        //address asset = address(0x2433A1b6FcF156956599280C3Eb1863247CFE675);
        bytes memory _parameters = abi.encode(asset, msg.sender);
        bytes memory _callFunc =  abi.encodeWithSignature("getUserReserveData(address,address)", _parameters);

        (bool success, bytes memory result) = ladingPool.staticcall(_callFunc);
        
        require(success, 
              "Execution failed"
        );

        (uint256 currentATokenBalance,
         uint256 currentBorrowBalance,
         uint256 principalBorrowBalance,
         uint256 borrowRateMode,
         uint256 borrowRate,
         uint256 liquidityRate,
         uint256 originationFee,
         uint256 variableBorrowIndex,
         uint256 lastUpdateTimestamp
         //bool usageAsCollateralEnabled
        ) = abi.decode(result, (uint256,
         uint256,
         uint256,
         uint256,
         uint256,
         uint256,
         uint256,
         uint256,
         uint256
        ));

        return currentATokenBalance;
    
    }
    
    function withdraw (uint256 _amount) public {
        //address asset = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        address asset = address(0x2433A1b6FcF156956599280C3Eb1863247CFE675);
        
        bytes memory _parameters = abi.encode(asset, msg.sender, _amount, 0);
        bytes memory _callFunc =  abi.encodeWithSignature("redeemUnderlying(address,address payable,uint256,uint256)", _parameters);


        (bool success, bytes memory result) = ladingPool.delegatecall(_callFunc);
        
        require(success, 
              "Execution failed"
        );

    }

}