// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract SimpleStorage{
    // 状态变量用来存储数字
    uint256 public num;
    // 需要发送一个交易 来 写 num变量
    function set(uint256 _num) public {
        num = _num;
    }
    // 从状态变量中读取数据，无需发送 交易
    function get() public view returns(uint256){
        return num;
    }
}