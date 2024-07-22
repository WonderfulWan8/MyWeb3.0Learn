// 怎么发送eth？
// 可以通过以下方式将eth发送到其它合约
// - transfer （2300gas 抛出异常）
// - send （2300gas 返回值为bool）
// - call （转发所有gas或者设置定额gas 返回值为bool）
// 怎么接收eth？
// 接收以太币的合约必须至少具有以下功能之一
// - receive() external payable
// - fallback() external payable
// 如果msg.data返回值为空 调用 receive否则调用fallback
// 应该用哪个？
// call与reentrancy guard结合使用是2019年12月之后的推荐方法
// Guard asainst re-entrancy by
//  - 在调用其它合约之前进行所有状态更改
//  - 使用 re-entrancy 保护修改
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract ReceiverEther{
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */
    // 接收eth的函数 返回值必须为空
    receive() external payable { }
    // 当msg.data不为空时 将调用fallback函数
    fallback() external payable{}
    function getBalance() public view returns (uint256){
        return address(this).balance;
    }
}
contract SendEther{
    function sendViaTransfer(address payable _to) public payable {
        // 不再推荐使用此功能发送以太币
        _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable {
        // send返回一个bool值 表示成功或者失败
        bool sent = _to.send(msg.value);
        require(sent,"Failed to send Ether");
    }
    function sendViaCall(address payable _to) public payable {
        // 调用返回一个指示成功或失败的布尔值。
        // 这是目前推荐使用的方法。
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent,"Failed to send Ether");
    }
}