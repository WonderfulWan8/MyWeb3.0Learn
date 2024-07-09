// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Primitives {
    bool public boo = true;

    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;
    // 使用type(int256).min获取int256类型能表示的最小值，即-2^255。
    int256 public minInt = type(int256).min;
    // 使用type(int256).max获取int256类型能表示的最大值，即2^255 - 1。
    int256 public maxInt = type(int256).max;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo;// false
    uint256 public defaultUint;// 0
    int256 public defaultInt;// 0
    address public defaultAddr;// 0x0000000000000000000000000000000000000000
}