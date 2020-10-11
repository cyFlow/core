pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './CFCommon.sol';
import './CFEnvironment.sol';
import './CFBrokerManeger.sol';

contract CFProductAave
{
    CFEnvironment  private env;
    CFBrokerManager private brokerManager;
    string nameBroker = 'aave';
    address mainAsset;
    uint256 rate = 0;
    uint256 earning = 0;
    
    mapping(address=>uint256) usingProducts;
    
    
    function registProductInBroker(address _broker) private
    {
        if(!brokerManager.isBroker(nameBroker))
           return;
        brokerManager.add(nameBroker, _broker);
    }
    constructor(address _env, address _brokerManager, address _broker) public
    {
        env = CFEnvironment(_env);
        brokerManager = CFBrokerManager(_brokerManager);
        registProductInBroker(_broker);
        mainAsset = env.getETH();
    }
    
    modifier owner (address _sender) {
        require(_sender == tx.origin, 'bad address');
        _;
    }
    
    /*
      invest ETH
      input address sender and amount to invest
    */
    function invest (address _sender, uint256 _amount) external owner(_sender)
    {
        CFAsset memory _asset = CFAsset({asset:env.getETH(), amount:_amount});
        CFAsset[] memory _assets = new CFAsset[](1);
        _assets[0] = _asset;
        brokerManager.invest(nameBroker, _assets);
        usingProducts[_sender] += _amount;
    }

    /*
      withdraw ETH
      input address sender
    */
    function withdraw (address _sender) external owner(_sender)
    {
        CFAsset memory _asset = CFAsset({asset:env.getETH(), amount:usingProducts[_sender]});
        CFAsset[] memory _assets = new CFAsset[](1);
        _assets[0] = _asset;
        brokerManager.withdraw(nameBroker, _assets);
    }

    /*
       How many eanoing todaty
    */
    function getEarningsToDate(address _sender) external view returns (uint256 amount)
    {
       return earning;       
    }
    
    /*
       Rate of current interest    
    */
    function getCurrentInterestRate(address _sender) external view returns (uint256 amount)
    {
        return rate;
    }


}