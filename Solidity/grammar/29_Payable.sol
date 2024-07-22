// 合约以及地址 用payable声明可以接收eth在合约中
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Payable{
    // 支付地址可以通过转账或者发送eth
    address payable public owner;
    constructor() payable {
        owner = payable (msg.sender);
    }
    // 将以太存款到合约中 使用一些eth来调用这个函数 此合约的余额将自动更新
    function deposit() public payable {}
    
    // 使用eth调用此函数 该函数将抛出错误 因为该函数不可支付
    function notPayable() public {}

    // 此函数将从该合约中提取所有以太币
    function withDraw() public {
        // 获取此合约中存储的以太币数量
        uint256 amount = address(this).balance;
        
        // 将所有的以太币发送给合约所有者
        (bool success,) = owner.call{value:amount}("");
        require(success,"failed to send eth");
    }
    // 将以太币从该合约转移到输入地址的函数
    function transfer(address payable _to,uint256 _amount) public {    
        // 请注意 to 被声明为应付款
        (bool success,) = _to.call{value: _amount}("");
        require(success,"Failed to send eth");
    }
}