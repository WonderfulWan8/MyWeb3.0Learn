// 你可以通过声明一个接口与其它合约交互
// 接口
// - 不能实现任何函数
// - 可以通过其它接口继承
// - 所有声明的函数必须是外部的
// - 不能声明状态变量
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Counter{
    uint256 public count;
    function increment() external {
        count += 1;
    }
}
interface ICounter {
    function count() external view returns (uint256);
    function increment() external;
}
contract MyContract{
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }
    function getCount(address _counter) external view returns (uint256){
        return ICounter(_counter).count();
    }
}