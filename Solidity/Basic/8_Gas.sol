// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Gas{
    uint256 public i=0;
    // gas余额为0会导致交易失败
    // 状态改变会撤销
    // gas花费不会退还
    function forever() public{
        // 这里，执行一个死循环，直到所有gas消耗光
        // 然后，交易失败
        while (true){
            i += 1;
        }
    }
}