// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract ViewAndPure{
    // 
    uint256 public x = 1;
    // 保证不修改状态
    function addToX(uint256 y) public view returns(uint256){
        return x+y;
    }
    // 保证不修改或者读取状态
    function add(uint256 i,uint256 j)public pure returns (uint256){
        return i+j;
    }
    // 总结：
    // pure函数不读取也不修改合约
    // view函数可以读取但不能修改合约状态
}