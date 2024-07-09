// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Variables{
    // 2、状态变量 存储在区块链上
    string public text = "hello";
    uint256 public num = 123;
    function doSomething() public{
        // 1、本地变量 在函数内部声明 不会存储在区块链上
        uint256 public i = 456;
        // 3、全局变量
        uint256 timestamp = block.timestamp; // 当前区块的时间戳
        address sender = msg.sender; //来电者地址
    }
}