// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
    映射 (keyType => valueType) 创建的
    k v 都可以是任何类型 包括另一个mapping或者array 
    mapping不可以迭代
*/
contract Mapping {
    mapping(address => uint256) public myMap;
    function get(address _addr) public view returns (uint256) {
        return myMap[_addr];
    }
    function set(address _addr, uint256 _i) public {
        myMap[_addr] = _i;
    }
    function remove(address _addr) public {
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // 嵌套mapping 从地址映射到另一个mapping
    mapping(address => mapping(uint256 => bool)) public nested;
    function get(address _addr, uint256 _i) public view returns (bool) {
        return nested[_addr][_i];
    }
    function set(address _addr, uint256 _i, bool _boo) public {
        nested[_addr][_i] = _boo;
    }
    function remove(address _addr, uint256 _i) public {
        delete nested[_addr][_i];
    }
}
