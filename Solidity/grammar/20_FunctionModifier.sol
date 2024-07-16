// _ 叫做修饰符 修饰符是可以在函数调用之前和之后运行的代码
// 修饰符可用于：限制访问、可调输入、防止重复性的黑客攻击


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract FunctionModifier{
    // 我们将用下列变量证明如何使用 _ 
    address public owner;
    uint256 public x = 10;
    bool public locked;
    constructor(){
        // 设置交易的的发送者为合约的拥有者
        owner = msg.sender;
    }
    // 使用修饰符来确认 调用这是合约的拥有者
    modifier onlyOwner(){
        require(msg.sender == owner,"not owner");
        _;
    }
    // 修饰符可以用于输入。这里的修饰符用于确认传入的地址是否为0地址
    modifier validAddress(address _addr){
        require(_addr != address(0),"not valid address");
        _;
    }
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
        owner = _newOwner;
    }
    // 这个修饰符防止函数在执行还未结束前再次被调用
    modifier noReentrancy(){
        require(!locked,"No reentrancy");
        locked = true;
        _;
        locked = false;
    }
    function decrement(uint256 i) public noReentrancy{
        x -= i;
        if(i > 1){
            decrement(i - 1);
        }
    }
}