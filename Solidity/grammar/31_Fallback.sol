// fallback是一个特殊的函数 在以下的情况执行：
// - 调用的函数不存在
// -  以太币发送到合约 但receive()不存在或者msg.data不为空
// 当通过transfer或send调用时,fallback具有2300gas的限制
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Fallback {
    event Log(string func,uint256 gas);
    // fallback 函数必须声明为 external
    fallback() external payable {
        // 发送/传输 (将2300gas转发到此回退功能
        // 调用（转发所有气体）
        emit Log("fallback",gasleft());
    }
    // receive函数是fallback函数的变体 当msg.data为空时触发
    receive() external payable {
        emit Log("receive",gasleft());   
    }
    function getBalance() public view returns (uint256){
        return address(this).balance;
    }
}
contract SendToFallback{
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }
    function callFallBack(address payable _to) public payable {
        (bool sent,) = _to.call{value:msg.value}("");
        require(sent,"Failed to send Ether");
    }
}
