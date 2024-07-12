// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// 变量被声明为存储、内存或调用数据，以显式的方式，指定数据的位置。
// storage - 变量为状态变量，存储在区块链上 操作这种变量需要花费gas
// memory - 变量存储在内存中，并且在函数调用时存在 不需要花费gas
// calldata - 给函数传递入参的数据存储在calldata 只读不可更改
contract DataLocation{
    uint256[] public arr;
    mapping (uint256 => address) map;
    struct MyStruct{
        uint256 foo;
    }
    mapping (uint256 => MyStruct) myStructs;
    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // 从mapping中读取一个结构体
        MyStruct storage myStruct = myStructs[1];
        // 在内存中创建一个结构体
        MyStruct memory myMemStruct = myStructs[0];
    }
    function _f(uint256[] storage _arr,mapping (uint256 => address) storage _map,MyStruct storage _myStruct) internal {
        // 用状态变量做些什么...
    }
    // 可以用这个函数返回内存变量
    function g(uint256[] memory _arr) public returns (uint256[] memory){
        // 用内存中的arr做些什么...
    }
    function h(uint256[] calldata _arr) external {
        // 用 calldata中传来的 arr做些什么...
    }

}