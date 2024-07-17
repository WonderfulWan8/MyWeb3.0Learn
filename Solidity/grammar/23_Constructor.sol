// 构造函数是一个可选函数 在合约创建时执行
// 下面是如何将参数传递给构造函数的示例
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract X{
    string public name;
    constructor(string memory _name){
        name = _name;
    }
}
contract Y{
    string public text;
    constructor(string memory _text){
        text = _text;
    }
}
// 有两种方法可以使用参数初始化父合约

// 在继承列表中传递参数
contract B is X("Input to x"),Y("Input to Y"){}

contract C is X,Y {
    // 在构造函数中传递参数
    // 类似于函数修饰符
    constructor(string memory _name,string memory _text) X(_name) Y(_text){}
}

// 父构造函数总是按继承顺序调用
// 不管更早的父合约在子合约的构造参数中
// 更早的构造函数 1.X 2.Y 3.D
contract D is X,Y{
    constructor() X("X was called") Y("Y was called"){}
}
// 更早的构造函数 1.X 2.Y 3.E
contract E is X,Y{
    constructor() Y("Y is called") X("X was called"){}
} 