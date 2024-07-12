// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 你可以自定义你的类型通过创造结构体
// 它们对于将相关的数据分组在一起很有用
// 结构体可以从外部导入
contract Todos{
    struct Todo{
        string text;
        bool completed;
    }
    // 一个元素类型为 'Todo' 结构体的数组
    Todo[] public todos;
    function create(string calldata _text) public {// calldata关键字表明 _text参数是从外部传递给合约的 它的数据存储在calldata
        // 3种方式初始化结构体
        // - function
        todos.push(Todo(_text,false));
        // key value mapping
        todos.push(Todo({text:_text,completed:false}));
        // 初始一个空的结构体 然后为其赋值
        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
    }
    // solidity 会默认创建一个getter 给 todos，所以不需要主动声明下列方法
    function get(uint256 _index) public view returns (string memory text,bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text,todo.completed);
    }
    // 更新 代办内容
    function updateText(uint256 _index,string calldata _text ) public {
        // 当你想要修改合约的存储数据（即持久化数据）时，你需要使用storage关键字来创建一个引用。这个引用指向存储在合约存储中的特定数据项，并允许你直接修改它。
        Todo storage todo = todos[_index];// 从合约的存储中读取todos[_index]变量的值 
        todo.text = _text;
    }
    // 完成代办
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = todos[_index];
        todo.completed = true;
    }
}