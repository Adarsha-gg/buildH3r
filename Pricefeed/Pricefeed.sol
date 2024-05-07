
// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@api3/contracts/api3-server-v1/proxies/interfaces/IProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Pricer is Ownable{
    address public  ethPriceFeed;
    address public  bitPriceFeed;
    constructor() Ownable(msg.sender) {}

    function setUp(address _ethPriceFeed, address _btcPriceFeed) external onlyOwner{
        ethPriceFeed = _ethPriceFeed;
        bitPriceFeed = _btcPriceFeed;
    }

    function readEthFeed() public view  returns(uint256, uint256){
        (int224 value, uint256 timestamp) = IProxy(ethPriceFeed).read();
        uint256 price = uint224(value);
        return (price, timestamp);
    }

    function readBitcoinFeed() public view  returns(uint256, uint256){
        (int224 value, uint256 timestamp) = IProxy(bitPriceFeed).read();
        uint256 price = uint224(value);
        return (price, timestamp);
    }
}