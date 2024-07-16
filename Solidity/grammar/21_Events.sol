// 事件允许记录到以太坊区块链。事件的一些用例包括：
// 监听用户事件并更新界面
// 一种廉价的存储方式

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Event{
    event Log(address indexed sender,string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender,"Hello World");
        emit Log(msg.sender,"Hello EVM");
        emit AnotherLog();
    }
}