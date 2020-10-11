pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;
import './CFCommon.sol';
import './CFEnvironment.sol';
import './CFBrokerManeger.sol';
import './ICFProduct.sol';

contract CFProductAave is ICFProduct
{
    CFEnvironment  private env;
    CFBrokerManager private brokerManager;
    address nameBroker = address(0xB72Fa7ecb92BA7D00470560a152269f96264fD08);
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
    
    
    constructor() public
    {
        address _env = address(0xc8848086E7e3eb34DEd2DE9273545064ac0EAa56);
        address _brokerManager = address(0xC2bE374D451b14AC6aEcbAF877c95F6B772347c7);
        address _broker = address(0xFd2d7751F84F9D86C460F7ea90645B760e58b8d9);
        env = CFEnvironment(_env);
        brokerManager = CFBrokerManager(_brokerManager);
        registProductInBroker(_broker);
        mainAsset = env.getETH();
    }
    
    function setBrokerManadfer(address _brokerManager) external
    {
        brokerManager = CFBrokerManager(_brokerManager);
    }

    function setBroker(address _broker) external
    {
        registProductInBroker(_broker);
    }
    
    modifier owner (address _sender) {
        require(_sender == tx.origin, 'bad address');
        _;
    }
    

    /*
      invest ETH
      input address sender and amount to invest
    */
    function invest (address _sender, uint256 _amount) external override owner(_sender)
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
    function withdraw (address _sender) external override owner(_sender)
    {
        CFAsset memory _asset = CFAsset({asset:env.getETH(), amount:usingProducts[_sender]});
        CFAsset[] memory _assets = new CFAsset[](1);
        _assets[0] = _asset;
        brokerManager.withdraw(nameBroker, _assets);
    }

    /*
       How many eanoing todaty
    */
    function getEarningsToDate(address _sender) external view override returns (uint256 amount)
    {
       return earning;       
    }
    
    /*
       Rate of current interest    
    */
    function getCurrentInterestRate(address _sender) external view override returns (uint256 amount)
    {
        return rate;
    }


}